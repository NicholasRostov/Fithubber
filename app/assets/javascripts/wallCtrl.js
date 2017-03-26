/* global angular */
(function() {
  "use strict";

  angular.module("app").controller("wallCtrl", function($scope, $http) {
    $scope.setup = function() {    
      $http.get("/api/v1/posts.json").then(function(response) {
        $scope.posts = response.data;
      });
    };

    $scope.addPost = function(newPost, newPhoto, newUrl) {
      console.log("love me!");
      var postParams = {body: newPost, photo: newPhoto, url: newUrl};
      $http.post("/api/v1/posts.json", postParams).then(function(response) {
        $scope.posts.push(response.data);
        console.log(response.data);
        console.log($scope.posts);
        $scope.inputPost = null;
        $scope.inputPhoto = null;
        $scope.inputUrl = null;
        $scope.errors = null;
      }, function(error) {
        console.log(error);
        $scope.errors = error.data.errors;
      });
      
      
    };

    $scope.killPost = function(post) {
      var index = $scope.posts.indexOf(post);
      $http.delete("/api/v1/posts/" + post.id + ".json").then(function(response) {
        $scope.errors = null;
        $scope.posts.splice(index, 1);
      }, function(error) {
        console.log(error);
        $scope.errors = error.data.errors;
      });
    };

    
    window.$scope = $scope;
  });

})();
