require('lodash');

var angular = require('angular');

require('angular-ui-router');
var routesConfig = require('./routes');

var main = require('./app/main');

var componentsModule = require('./app/components/index');
var gameModule = require('./app/game/index');
var utilsModule = require('./app/utils/index');

require('./bundle.css');

angular
  .module('app', [componentsModule, gameModule, utilsModule, 'ui.router'])
  .config(routesConfig)
  .component('app', main);
