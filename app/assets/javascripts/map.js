var createMapLayer = function(type, options) {
  if (type == "osm") {
    return L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    });
  }
};

var createMapMarkerLayer = function(categories, projects, enablePopups, enableClustering) {
  customMarker = L.Marker.extend({
     options: { content_url: "" }
  });

  markers = L.markerClusterGroup({
    disableClusteringAtZoom: enableClustering ? 8 : 1,
  });
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
