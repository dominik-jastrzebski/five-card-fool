var angular = require('angular');

var playerCardsModule = 'player-cards';
module.exports = playerCardsModule;

var playerCardsDirective = require('./player-cards-directive');

angular.module(playerCardsModule, [])
  .directive('playerCards', playerCardsDirective);
