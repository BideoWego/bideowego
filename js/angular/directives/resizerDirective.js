// ----------------------------------------
// Resizer Directive
// ----------------------------------------


BideoWego.directive('resizer', ['$window', function ($window) {

    var _width = function() {
      return $window.innerWidth;
    };

    var _mq = function() {
      var mq;
      var width = _width();
      if (width < 768) {
        mq = 'xs';
      } else if (width >= 768 && width < 922) {
        mq = 'sm';
      } else if (width >= 992 && width < 1200) {
        mq = 'md';
      } else {
        mq = 'lg';
      }
      return mq;
    };

    return {
      restrict: 'A',
      link: function (scope, elem, attrs) {
        scope.mq = _mq();
        scope.width = _width();
        var eventListener = function(e) {
          scope.$apply(function(){
            scope.mq = _mq();
            scope.ww = _width();
          });
        };
        angular.element(document).on('ready', eventListener);
        angular.element($window).on('resize', eventListener);
      }
    };
}]);


