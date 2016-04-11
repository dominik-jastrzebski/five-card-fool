package Models;
use strict;
use warnings FATAL => 'all';
use 5.010;

{
    package Card;

    use List::MoreUtils qw(first_index);

    sub new {
        my $class = shift;
        my $code = shift;
        my $self = {
            'value' => substr($code, 0, 1),
            'suit' => substr($code, 1, 1)
        };
        bless $self, $class;
    }
    sub value {
        my $self = shift;
        return $self->{'value'};
    }
    sub suit {
        my $self = shift;
        return $self->{'suit'};
    }
    sub get_code {
        my $self = shift;
        return $self->{'value'} . $self->{'suit'};
    }
    sub compare {
        my $self = shift;
        my $that = shift;
        return (first_index {$_ eq $self->value} @CardValue::HIERARCHY) <=>
            (first_index {$_ eq $that->value} @CardValue::HIERARCHY);
    }
    sub compare_with_trump {
        my $self = shift;
        my $that = shift;
        my $trump = shift;
        if ($self->suit eq $trump && $that->suit ne $trump) {
            return 1;
        } elsif ($self->suit ne $trump && $that->suit eq $trump) {
            return -1;
        } else {
            return $self->compare($that);
        }
    }
}

{
    package CardValue;

    our $ACE = 'A';
    our $KING = 'K';
    our $QUEEN = 'Q';
    our $JACK = 'J';
    our $TEN = 'T';

    our @HIERARCHY = (
        2..9,
        $TEN,
        $JACK,
        $QUEEN,
        $KING,
        $ACE
    );
}

{
    package Suit;

    our $SPADES = 's';
    our $HEARTS = 'h';
    our $DIAMONDS = 'd';
    our $CLUBS = 'c';

    our @SUITS = (
        $CLUBS,
        $DIAMONDS,
        $HEARTS,
        $SPADES
    );
}

1;