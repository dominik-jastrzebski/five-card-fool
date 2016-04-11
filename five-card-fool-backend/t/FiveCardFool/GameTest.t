#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use Test::More tests => 1;
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