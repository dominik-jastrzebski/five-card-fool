var angular = require('angular');

var ngRepeatNModule = 'ng-repeat-n';
module.exports = ngRepeatNModule;

var ngRepeatNController = require('./ng-repeat-n-controller');
var ngRepeatNDirective = require('./ng-repeat-n-directive');

angular.module(ngRepeatNModule, [])
  .controller('NgRepeatNController', ngRepeatNController)
  .directive('ngRepeatN', ngRepeatNDirective);
