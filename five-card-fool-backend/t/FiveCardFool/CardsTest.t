#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 3;
use FiveCardFool::Cards;

subtest 'should provide value, suit and code getters' => sub {
        plan tests => 3;
        my $card = Card->new('Qh');
        is($card->value, 'Q');
        is($card->suit, $Suit::HEARTS);
        is($card->get_code, 'Qh');
    };

subtest 'should compare their values without trumps' => sub {
        plan tests => 3;
        my $a = Card->new('Ts');
        my $b = Card->new('As');
        is($a->compare($a), 0);
        is($a->compare($b), -1);
        is($b->compare($a), 1);
    };

subtest 'should be comparable with trumps' => sub {
        plan tests => 4;
        my $a = Card->new('Ah');
        my $b = Card->new('2s');
        my $c = Card->new('5s');

        is($a->compare_with_trump($b, $Suit::SPADES), -1);
        is($b->compare_with_trump($a, $Suit::SPADES), 1);

        is($b->compare_with_trump($c, $Suit::SPADES), -1);
        is($c->compare_with_trump($b, $Suit::SPADES), 1);
    };
