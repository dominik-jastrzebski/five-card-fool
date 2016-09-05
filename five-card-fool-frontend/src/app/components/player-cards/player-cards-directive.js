function PlayerCardsDirective() {
  return {
    restrict: 'E',
    scope: {
      'cards': '=',
      'onCardPlayed': '&'
    },
    template: require('./player-cards-directive.html')
  };
}

module.exports = PlayerCardsDirective;
