var angular = require('angular');

var ngRepeatN = require('./ng-repeat-n');

var utilsModule = 'utils';

module.exports = utilsModule;

angular
  .module(utilsModule, [ngRepeatN]);
