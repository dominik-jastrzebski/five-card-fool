function DeckOfCardsDirective() {
  return {
    restrict: 'E',
    scope: {
      deck: '='
    },
    template: require('./deck-of-cards-directive.html')
  };
}

module.exports = DeckOfCardsDirective;
