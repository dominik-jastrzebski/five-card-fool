package Game;

use warnings FATAL => 'all';
no warnings 'experimental::smartmatch';
use strict;

use FiveCardFool::Cards;

use Carp qw(croak);
use List::Util qw(shuffle);

our $STARTING = 'starting';
our $ATTACK = 'attack';
our $DEFENSE = 'defense';
our $FINISHED = 'finished';

sub new {
    my $class = shift;
    my $player_ids = shift;
    my $self = {};
    bless $self, $class;
    $self->{'player_ids'} = $player_ids;
    $self->{'state'} = $STARTING;
    $self->{'played_cards'} = [];
    $self->{'active_player'} = 0;
    $self->{'attacker'} = 0;
    $self->{'defender'} = 0;
    $self->_setup_deck();
    $self->_deal_cards();
    return $self;
}

sub state {
    my $self = shift;
    return $self->{'state'};
}

sub player_count {
    my $self = shift;
    return scalar @{$self->{'player_ids'}};
}

sub trump {
    my $self = shift;
    return $self->{'trump'};
}

sub cards_left {
    my $self = shift;
    return scalar @{$self->{'deck'}};
}

sub draw {
    my $self = shift;
    my $count = shift;
    return map { pop @{$self->{'deck'}} } 1..$count;
}

sub draw_to_five {
    my $self = shift;

    my $active_player_cards = $self->{'hands'}->[$self->{'active_player'}];
    my $card_count = scalar @$active_player_cards;

    if ($card_count < 5) {
        push(@$active_player_cards, $self->draw(5 - $card_count));
    }
}

sub start {
    my $self = shift;
    $self->{'active_player'} = int(abs(rand())) % $self->player_count;
    $self->{'state'} = $ATTACK;
}

sub can_attack {
    my $self = shift;
    my $cards = shift;
    if (!$self->_attacker_has_cards($cards)) {
        return 0;
    }
    my ($cards_count, $first_rank_count, $second_rank_count) = $self->_cards_summary($cards);

    if ($cards_count == 1) {
        return 1;
    } elsif ($cards_count == 3) {
        return [$first_rank_count, $second_rank_count] ~~ [3, 0] ||
                [$first_rank_count, $second_rank_count] ~~ [2, 1];
    } elsif ($cards_count == 5) {
        return [$first_rank_count, $second_rank_count] ~~ [4, 1] ||
            [$first_rank_count, $second_rank_count] ~~ [3, 2] ||
            [$first_rank_count, $second_rank_count] ~~ [2, 2];
    } else {
        return 0;
    }
}

sub attack {
    my $self = shift;
    my $cards = shift;
    $self->{'state'} = $DEFENSE;
    $self->_remove_cards($self->{'hands'}->[$self->{'attacker'}], $cards);
    $self->{'played_cards'} = $cards;
    $self->draw_to_five();
    $self->next_player();
}

sub can_defend {
    my $self = shift;
    my $cards = shift;

    my $played_cards_count = scalar @{$self->{'played_cards'}};
    my $defending_cards_count = scalar @$cards;

    if ($played_cards_count != $defending_cards_count) {
        return 0;
    }

    for (my $i = 0; $ i < $played_cards_count; $i++) {

    }

    return 1;
}

sub defend {
    my $self = shift;
    my $cards = shift;
    Carp::croak("Expected the game to be in '$DEFENSE' state!") if ($self->{'state'} != $DEFENSE);
    my $full_defense = 0;
    # TODO
    if ($full_defense) {

    } else {

    }
}

sub next_player {
    my $self = shift;
    $self->{'active_player'}++;
    $self->{'active_player'} %= $self->player_count;
    while (scalar @{$self->{'hands'}}[$self->{'active_player'}] == 0) {
        $self->{'active_player'}++;
        $self->{'active_player'} %= $self->player_count;
    }
}

sub _full_deck {
    my @deck = ();
    foreach my $suit (@Suit::SUITS) {
        foreach my $value (@CardValue::HIERARCHY) {
            push(@deck, Card->new($value.$suit));
        }
    }
    return @deck;
}

sub _shuffled_deck {
    return shuffle(_full_deck());
}

sub _setup_deck {
    my $self = shift;
    @{$self->{'deck'}} = _shuffled_deck();
    $self->{'trump'} = $self->{'deck'}[0]->suit;
}

sub _deal_cards {
    my $self = shift;
    my $player_ids = $self->{'player_ids'};
    @{$self->{'hands'}} = map { [] }  1..(scalar @$player_ids);
    for (my $i = 0; $i < scalar @$player_ids; $i++) {
        @{$self->{'hands'}->[$i]} = $self->draw( 5 );
    }
}

sub _remove_cards {
    my $self = shift;
    my $hand = shift;
    my $cards = shift;
    my @card_codes = map { $_->get_code() } @$cards;
    @$hand = grep { !($_->get_code() ~~ @card_codes) } @$hand;
}

sub _attacker_has_cards {
    my $self = shift;
    my $cards = shift;
    my @card_codes = map { $_->get_code()} @$cards;
    my @attacker_card_codes = map { $_->get_code() } @{$self->{'hands'}->[$self->{'attacker'}]};
    foreach my $card_code (@card_codes) {
        unless ($card_code ~~ @attacker_card_codes) {
            return 0;
        }
    }
    return 1;
}

sub _cards_summary {
    my $self = shift;
    my $cards = shift;
    my $card_count = scalar @$cards;
    my %rank_occurences = ();

    foreach my $card (@$cards) {
        if (!$rank_occurences{$card->value()}) {
            $rank_occurences{$card->value()} = 1;
        } else {
            $rank_occurences{$card->value()}++;
        }
    }

    my @keys = sort { -$rank_occurences{$a} <=> -$rank_occurences{$b} } (keys %rank_occurences);
    if (scalar @keys == 1) {
        $keys[1] = 0;
    }

    return ($card_count, $rank_occurences{$keys[0]}, $rank_occurences{$keys[1]})
}

1;