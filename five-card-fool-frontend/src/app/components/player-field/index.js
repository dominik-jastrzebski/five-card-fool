var angular = require('angular');

var playerFieldModule = 'player-field';
module.exports = playerFieldModule;

var playerFieldDirective = require('./player-field-directive');

angular.module(playerFieldModule, [])
  .directive('playerField', playerFieldDirective);
