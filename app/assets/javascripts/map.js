var createMapLayer = function(options) {
  return L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}',
    $.extend({
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 18,
    }, options)
  )
};

var createMapMarkerLayer = function(categories, projects, enablePopups) {
  customMarker = L.Marker.extend({
     options: { content_url: "" }
  });

  markers = L.markerClusterGroup();
  window.openMarker = null;
  var icons = []

  categories.forEach(function(d) {
    icons[d.id] = L.VectorMarkers.icon({
      markerColor: d.color,
      icon: "dot-circle-o",
    });
  });

  projects.forEach(function(d) {
    m = new customMarker([ d.x, d.y ], { icon: icons[d.cat_id], content_url: d.url });
    if (enablePopups)
      m.bindPopup("<div class='popup-dummy'><p>Loading ... </p><i class='fa fa-spinner fa-spin fa-3x'></i></div>");

    markers.addLayer(m);

    if (d.open)
      window.openMarker = m;
  });

  return markers;
};