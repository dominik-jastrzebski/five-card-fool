var angular = require('angular');

var deckOfCardsModule = 'deck-of-cards';
module.exports = deckOfCardsModule;

var deckOfCardsDirective = require('./deck-of-cards-directive');

angular.module(deckOfCardsModule, [])
  .directive('deckOfCards', deckOfCardsDirective);
