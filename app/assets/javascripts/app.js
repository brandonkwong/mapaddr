var mapAddr = angular.module('MapAddr', []);

mapAddr.controller('MapAddrController', ['$scope', function($scope) {

  // Map
  var map;

  // Map Options
  var mapOptions = {
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    styles: stylized,
    minZoom: 3,
    zoom: 17
  };

  // Geolocation
  var initialLocation;
  var browserSupportFlag = new Boolean();
  var siberia = new google.maps.LatLng(60, 105);
  var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);

  // Geocoder
  var geocoder;
  var infowindow = new google.maps.InfoWindow();

  // // Directions
  // var directionsDisplay;
  // var directionsService = new google.maps.DirectionsService();


  // Google Maps Initialize
  $scope.mapInit = function() {

    // Map-Canvas Id
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    // Geolocation (W3C Preferred)
    if(navigator.geolocation) {
      browserSupportFlag = true;
      navigator.geolocation.getCurrentPosition(function(position) {
        initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);

        // Add Current Location Function
        $scope.currentLocation = function() {
          $scope.geoLoc = initialLocation;
        }

        // Current Location Marker
        var geoMarker = new google.maps.Marker({
          map: map,
          position: initialLocation,
          title: 'Current Location'
        });

        // Current Location Radius
        var circle = {
          strokeColor: '#b163a3',
          strokeOpacity: 0,
          strokeWeight: 0,
          fillColor: '#b163a3',
          fillOpacity: 0.15,
          map: map,
          center: initialLocation,
          radius: 250
        };
        geoCircle = new google.maps.Circle(circle);

        // Current Location Info Window
        infowindow.setContent('What up!');
        infowindow.open(map, geoMarker);

        map.setCenter(initialLocation);

      }, function() {
        handleNoGeolocation(browserSupportFlag);
      });
    }
    // Browser doesn't support Geolocation
    else {
      browserSupportFlag = false;
      handleNoGeolocation(browserSupportFlag);
    }

    function handleNoGeolocation(errorFlag) {
      if (errorFlag == true) {
        alert("Geolocation service failed.");
        initialLocation = newyork;
      } else {
        alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
        initialLocation = siberia;
      }
      map.setCenter(initialLocation);
    }

    // directionsDisplay = new google.maps.DirectionsRenderer();



  }();




  // Geocoding
  geocoder = new google.maps.Geocoder();
  $scope.codeAddress = function(address) {
    geocoder.geocode({'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        // map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  };

  // Take Me There
  $scope.takeMe = function(address) {
    geocoder.geocode({'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  };


  


  // // Directions
  // function calcRoute() {
  //   var start = document.getElementById("start").value;
  //   var end = document.getElementById("end").value;
  //   var request = {
  //     origin:start,
  //     destination:end,
  //     travelMode: google.maps.TravelMode.DRIVING
  //   };
  //   directionsService.route(request, function(result, status) {
  //     if (status == google.maps.DirectionsStatus.OK) {
  //       directionsDisplay.setDirections(result);
  //     }
  //   });
  // }




}]);