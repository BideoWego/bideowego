// ----------------------------------------
// BlogCtrl
// ----------------------------------------

var BideoWego = angular.module('BideoWego', ['ngSanitize']);


BideoWego.filter('toDate', function() {
  return function(str) {
    return new Date(str);
  };
});


