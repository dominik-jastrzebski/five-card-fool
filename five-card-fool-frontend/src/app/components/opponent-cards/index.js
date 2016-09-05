var angular = require('angular');

var opponentCardsModule = 'opponent-cards';
module.exports = opponentCardsModule;

var opponentCardsDirective = require('./opponent-cards-directive');

angular.module(opponentCardsModule, [])
  .directive('opponentCards', opponentCardsDirective);
