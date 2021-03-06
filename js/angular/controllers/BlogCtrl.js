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
    $scope.order = { direction: '' };
    $scope.q = '';


    $http.get('/data/site.json')
      .then(function(response) {
        $scope.posts = response['data']['posts'];
        $scope.archives = response['data']['archives'];
        $scope.categories = response['data']['categories'].sort();
        $scope.tags = response['data']['tags'].sort();
      });


    $scope.postExcerpt = function(id) {
      return $sce.trustAsHtml($scope.posts[id]['excerpt']);
    };


    $scope.setQ = function(q) {
      $scope.q = q;
      angular.element('a[href="#tab-posts"]').trigger('click');
    };


    $scope.clearQ = function() {
      $scope.q = '';
    };


    $scope.setOrder = function() {
      $scope.order.direction = ($scope.order.direction === '') ? '-' : '';
    };

  }]);






