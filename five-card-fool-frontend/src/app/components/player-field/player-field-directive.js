function PlayerFieldDirective() {
  return {
    restrict: 'E',
    scope: {
      cards: '=',
      playable: '=',
      onCardUndo: '&'
    },
    template: require('./player-field-directive.html')
  };
}

module.exports = PlayerFieldDirective;
