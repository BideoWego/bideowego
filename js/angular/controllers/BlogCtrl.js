// ----------------------------------------
// BlogCtrl
// ----------------------------------------

BideoWego.controller('BlogCtrl',
  ['$scope', '$http', '$sce',
  function($scope, $http, $sce) {

    $scope.posts = [];
    $scope.archives = [];
    $scope.categories = [];
    $scope.tags = [];
    $scope.q = '';


    $http.get('/data/site.json')
      .then(function(response) {
        $scope.posts = response['data']['posts'];
        $scope.archives = response['data']['archives'];
        $scope.categories = response['data']['categories'];
        $scope.tags = response['data']['tags'];
      });


    $scope.postExcerpt = function(id) {
      return $sce.trustAsHtml($scope.posts[id]['excerpt']);
    };


    $scope.setQ = function(q) {
      console.log(q);
      $scope.q = q;
      $('a[href="#tab-posts"]').trigger('click');
    };


    $scope.clearQ = function() {
      $scope.q = '';
    };

  }]);






