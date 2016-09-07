#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use Test::More tests => 4;

use FiveCardFool::Cards;
use FiveCardFool::Game;

# Mock the deck shuffling so the deck does not get shuffled
{
    package Game;
    sub _shuffled_deck {
        return _full_deck();
    }
}

subtest 'should initialize the game properly' => sub {
        plan tests => 3;
        my $game = Game->new([1, 2, 3, 4]);

        is($game->state, $Game::STARTING);
        is($game->player_count, 4);

        is_deeply(
            [map { [map { $_->get_code } @$_] } @{$game->{'hands'}}],
            [
                ['As', 'Ks', 'Qs', 'Js', 'Ts'],
                ['9s', '8s', '7s', '6s', '5s'],
                ['4s', '3s', '2s', 'Ah', 'Kh'],
                ['Qh', 'Jh', 'Th', '9h', '8h']
            ]
        );
    };

my @attacker_cards = (Card->new('Kh'), Card->new('Kc'), Card->new('Qs'), Card->new('Qd'), Card->new('5c'));
my @three_card_attack = (Card->new('Kh'), Card->new('Kc'), Card->new('5c'));

subtest 'should allow valid attacks' => sub {
        plan tests => 3;
        my $game = Game->new([1, 2, 3, 4]);

        $game->{'state'} = $Game::ATTACK;
        @{$game->{'hands'}->[0]} = @attacker_cards;

        ok($game->can_attack([$attacker_cards[0]]));
        ok($game->can_attack([@three_card_attack]));
        ok($game->can_attack([@attacker_cards]));
    };


subtest 'should not allow invalid attacks' => sub {
        plan tests => 3;
        my $game = Game->new([1, 2, 3, 4]);

        $game->{'state'} = $Game::ATTACK;

        @{$game->{'hands'}->[0]} = @attacker_cards;

        ok($game->can_attack([Card->new('Kh')]));
        ok($game->can_attack([Card->new('Kh'), Card->new('Kc'), Card->new('5c')]));
        ok($game->can_attack([@attacker_cards]));
    };


subtest 'should perform an attack correctly' => sub {
        plan tests => 4;
        my $game = Game->new([1, 2, 3, 4]);

        $game->{'state'} = $Game::ATTACK;
        @{$game->{'hands'}->[0]} = @attacker_cards;

        my $deck_cards = [Card->new('9d'), Card->new('9h'), Card->new('9s')];
        $game->{'deck'} = $deck_cards;

        $game->attack([@three_card_attack]);

        is($game->{'state'}, $Game::DEFENSE);
        is($game->{'active_player'}, 1);
        is_deeply($game->{'played_cards'}, [@three_card_attack]);
        is_deeply($game->{'hands'}->[0], [Card->new('Qs'), Card->new('Qd'), Card->new('9s'), Card->new('9h'), Card->new('9d')]);
    };
