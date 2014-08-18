var mapAddr = angular.module('MapAddr', []);

mapAddr.controller('MapAddrController', ['$scope', function($scope) {

  // Map
  var map;
  var mapOptions = {
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    mapTypeControl: false,
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

        // Current Location Radius
        var geoCircle = new google.maps.Circle({
          fillColor: '#b163a3',
          fillOpacity: 0.15,
          strokeColor: 'none',
          strokeOpacity: 0,
          strokeWeight: 0,
          map: map,
          center: initialLocation,
          radius: 250
        });

        // Current Location Marker
        $scope.geoMarker = new google.maps.Marker({
          map: map,
          position: initialLocation,
          title: 'Current Location',
          icon: {
            anchor: new google.maps.Point(30, -30),
            fillColor: '#b163a3',
            fillOpacity: 1,
            path: fontawesome.markers.USER,
            scale: 0.65,
            strokeColor: 'none',
            strokeOpacity: 0,
            strokeWeight: 0
          }
        });

        // Current Location Info Window
        infowindow.open(map, $scope.geoMarker);
        infowindow.setContent('<h4>What up!</h4>');

        // Current Location Info Window on Click
        google.maps.event.addListener($scope.geoMarker, 'click', function() {
          infowindow.open(map, $scope.geoMarker);
          infowindow.setContent('<h4>What up!</h4>');
        });

        // Map Center
        map.setCenter(initialLocation);
        map.panBy(0, 30);

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
      map.panBy(0, 30);
    }

    // directionsDisplay = new google.maps.DirectionsRenderer();


  }();

  // Go to Current Location Button
  $scope.locateMe = function() {
    geocoder.geocode({'address': String(initialLocation)}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {

        // Center and Zoom in on Current Location
        map.setCenter(results[0].geometry.location);
        map.setZoom(17);
        map.panBy(0, 30);

        // Current Location Info Window
        infowindow.open(map, $scope.geoMarker);
        infowindow.setContent('<h4>Such a beautiful day!</h4>');

      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  };

  // Go to Location on Click
  $scope.takeMe = function(address, name) {
    geocoder.geocode({'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {

        // Center and Zoom in on Location
        map.setCenter(results[0].geometry.location);
        map.setZoom(17);
        map.panBy(0, 30);

        // Create Marker for on Click
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          icon: {
            anchor: new google.maps.Point(20, -30),
            fillColor: '#b163a3',
            fillOpacity: 1,
            path: fontawesome.markers.MAP_MARKER,
            scale: 0.65,
            strokeColor: 'none',
            strokeOpacity: 0,
            strokeWeight: 0
          }
        });

        // Location Info Window
        infowindow.open(map, marker);
        infowindow.setContent(
          '<h4>' + name + '</h4>' +
          '<p class="addr-text">' + address + '</p>'
        );

      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  };

  // Add New Location with Current Location
  $scope.currentLocation = function() {
    $scope.geoLoc = initialLocation;
  };

  // Geocoding
  geocoder = new google.maps.Geocoder();
  $scope.codeAddress = function(address, name) {
    geocoder.geocode({'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {

        // Create Markers for All Locations
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          icon: {
            anchor: new google.maps.Point(20, -30),
            fillColor: '#b163a3',
            fillOpacity: 1,
            path: fontawesome.markers.MAP_MARKER,
            scale: 0.65,
            strokeColor: 'none',
            strokeOpacity: 0,
            strokeWeight: 0
          }
        });

        // Location Info Window on Click
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map, marker);
          infowindow.setContent(
            '<h4>' + name + '</h4>' +
            '<p class="addr-text">' + address + '</p>'
          );
        });

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