var _ = require('lodash');

function NgRepeatNController($scope) {
  $scope.getArray = function (size) {
    return _.range(0, size);
  };
}

module.exports = ['$scope', NgRepeatNController];
