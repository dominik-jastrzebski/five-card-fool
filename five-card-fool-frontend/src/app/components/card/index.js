var angular = require('angular');

var cardModule = 'card';
module.exports = cardModule;

var cardDirective = require('./card-directive');
var cardOffsetDirective = require('./card-offset-directive');
var hiddenCardDirective = require('./hidden-card-directive');

angular.module(cardModule, [])
  .directive('card', cardDirective)
  .directive('cardOffset', cardOffsetDirective)
  .directive('hiddenCard', hiddenCardDirective);
