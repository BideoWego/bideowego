// ----------------------------------------
// BlogCtrl
// ----------------------------------------

BideoWego.controller('BlogCtrl',
  ['$scope', '$http', '$sce',
  function($scope, $http, $sce) {

    $scope.posts = [];
    $scope.q = '';


    $http.get('/data/site.json')
      .then(function(response) {
        $scope.posts = response['data']['posts'];
        console.log(response['data']['posts']);
      });


    $scope.postExcerpt = function(id) {
      return $sce.trustAsHtml($scope.posts[id]['excerpt']);
    };


    $scope.toDate = function(str) {
      str = str.replace(/ \d\d:\d\d:\d\d \-\d\d\d\d/, '');
      return new Date(str);
    };
  }]);




