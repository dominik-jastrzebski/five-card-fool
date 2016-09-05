function OpponentCardsDirective() {
  return {
    restrict: 'E',
    scope: {
      cardCount: '='
    },
    template: require('./opponent-cards-directive.html')
  };
}

module.exports = OpponentCardsDirective;
