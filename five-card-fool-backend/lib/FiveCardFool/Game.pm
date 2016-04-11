package Game;
use strict;
use warnings FATAL => 'all';

use FiveCardFool::Cards;

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

sub start {
    my $self = shift;
    $self->{'active_player'} = int(abs(rand())) % $self->player_count;
    $self->{'state'} = $ATTACK;
}

sub attack {
    my $self = shift;
    my $cards = shift;
    $self->{'state'} = $DEFENSE;
    $self->next_player();
}

sub defend {
    my $self = shift;
    my $cards = shift;
}

sub next_player {
    my $self = shift;
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

1;