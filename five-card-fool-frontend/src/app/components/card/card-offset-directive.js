function CardOffsetDirective() {
  return {
    restrict: 'A',
    link: function (scope, element, attrs) {
      var isVertical = attrs.cardOffsetDirection === 'vertical';

      element.css('position', 'relative');
      var offset;

      if (isVertical) {
        offset = -9.0 * parseInt(attrs.cardOffsetIndex, 10);
        element.css('left', '0');
        element.css('top', offset + 'vw');
      } else {
        offset = -6.2 * parseInt(attrs.cardOffsetIndex, 10);
        element.css('left', offset + 'vw');
      }
    }
  };
}

module.exports = CardOffsetDirective;
