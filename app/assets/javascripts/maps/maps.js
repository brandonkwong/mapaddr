var initialLocation;
var marker;
var siberia = new google.maps.LatLng(60, 105);
var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
var browserSupportFlag =  new Boolean();
// var locations = [];

// Google Maps Initialize
function initialize() {
  
  // Location Latitutde and Longitude
  // var locations = [
  //   {
  //     lat: -25.363882,
  //     lng: 131.044922,
  //     title: 'Marker 1'
  //   },

  //   {
  //     lat: -50.363882,
  //     lng: 131.044922,
  //     title: 'Marker 2'
  //   },

  //   {
  //     lat: -33.363882,
  //     lng: 131.044922,
  //     title: 'Marker 3'
  //   },

  //   {
  //     lat: -44.363882,
  //     lng: 131.044922,
  //     title: 'Marker 4'
  //   }
  // ];

  // Map Options
  var mapOptions = {
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    styles: mapOverlay,
    zoom: 17
  };

  // Map-Canvas Id
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

  // Geolocation (W3C Preferred)
  if(navigator.geolocation) {
    browserSupportFlag = true;
    navigator.geolocation.getCurrentPosition(function(position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);

      // Marker for Current Location
      var marker = new google.maps.Marker({
        map: map,
        position: initialLocation,
        title: 'Current Location'
      });

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

  // Location Markers
  // for (var i = 0; i < locations.length; i++) {
  //   var marker = new google.maps.Marker({
  //     map: map,
  //     position: new google.maps.LatLng(locations[i].lat, locations[i].lng),
  //     title: locations[i].title
  //   });
  // }

}

// Google Maps Window Load
google.maps.event.addDomListener(window, 'load', initialize);
