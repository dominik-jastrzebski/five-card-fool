var angular = require('angular');

function GameTableController($scope) {
  $scope.gameState = {
    phase: 'ATTACK',
    player: {
      active: true,
      cards: ['2c', '3d', '4h'],
      field: ['4c']
    },
    // clockwise order from player's seat
    opponents: [
      {
        active: false,
        cardCount: 5,
        field: ['2s']
      }
    ],
    deck: {
      cardCount: 13,
      trumpCard: '10s'
    }
  };

  $scope.playCard = function (playedCard) {
    _.remove($scope.gameState.player.cards, function(card) { return card === playedCard });
    $scope.gameState.player.field.push(playedCard);
  };

  $scope.undoCard = function (clickedCard) {
    _.remove($scope.gameState.player.field, function(card) { return card === clickedCard});
    $scope.gameState.player.cards.push(clickedCard);
  };
}

var gameTableControllerModule = 'game-table-controller';
module.exports = gameTableControllerModule;

angular.module(gameTableControllerModule, [])
  .controller('GameTableController', GameTableController);
