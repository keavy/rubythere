var infowindow = null;
var infowindow = new google.maps.InfoWindow({
  content: '...'
});

function init_map(){
  var latlng = new google.maps.LatLng(56.46249,-4.87793);

  var myOptions = {
    zoom: 1,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  setMarkers(map)
}

function setMarkers(map){
  var bounds = new google.maps.LatLngBounds();

  for (var i = 0; i < locations.length; i++) {
    var latlng = new google.maps.LatLng(locations[i].lat,locations[i].lng);
    bounds.extend(latlng);
    var name = locations[i].name

    var message = '<a href="'+ locations[i].url + '"><strong>'+name+'</strong></a><br />'+
      locations[i].date + '<br />'+
      locations[i].location;

    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        title: name,
        message: message
    });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.setContent(this.message);
      infowindow.setPosition(latlng)
      infowindow.open(map,this);
    });
  }

  map.fitBounds(bounds);
}

