#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use 5.010;

use Mojolicious::Lite;
use FiveCardFool::Cards;
use FiveCardFool::Game;


get '/' => {text => 'Dureń!'};

app->start;
