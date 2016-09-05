function CardDirective() {
  return {
    restrict: 'E',
    scope: {
      cardValue: '@value',
      offset: '@offset'
    },
    template: require('./card-directive.html')
  };
}

module.exports = CardDirective;
