var angular = require('angular');

var gameTableController = require('./game-table-controller');

var gameModule = 'game';

module.exports = gameModule;

angular
  .module(gameModule, [gameTableController]);
