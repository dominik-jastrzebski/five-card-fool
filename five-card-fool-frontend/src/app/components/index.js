var angular = require('angular');

var card = require('./card');
var deckOfCards = require('./deck-of-cards');
var opponentCards = require('./opponent-cards');
var playerCards = require('./player-cards');
var playerField = require('./player-field');

var componentsModule = 'components';

module.exports = componentsModule;

angular
  .module(componentsModule, [card, deckOfCards, opponentCards, playerCards, playerField]);
