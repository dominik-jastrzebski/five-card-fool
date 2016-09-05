function NgRepeatNDirective($compile) {
  return {
    controller: 'NgRepeatNController',
    restrict: 'A',
    priority: 1001,
    terminal: true,
    link: function (scope, element, attrs) {
      element.removeAttr('ng-repeat-n');
      element.attr('ng-repeat', 'n in getArray(' + attrs.ngRepeatN + ')');
      $compile(element)(scope);
    }
  };
}

module.exports = ['$compile', NgRepeatNDirective];
