var infoWindow = new google.maps.InfoWindow();

function init_map(){
  var latlng = new google.maps.LatLng(56.46249,-4.87793);

  var myOptions = {
    zoom: 1,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  for (var i = 0; i < locations.length; i++) {
    var latlng = new google.maps.LatLng(locations[i].lat,locations[i].lng);
    var name = locations[i].name

    var message = '<strong>'+name+'</strong><br />'+
      '<a href="#{events_path}">Event info</a>';

    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        title: name
    });


  }
}
