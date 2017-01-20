jOnEachFeature <- '#! function(feature, layer){
  layer.bindPopup(feature.properties.popup)
} !#'

jStyle <- "#! function (feature) {
 return {color: feature.properties.color, 
         fillOpacity: feature.properties.fillOpacity, 
         fillColor: feature.properties.fillColor, 
         weight: feature.properties.weight};
} !#"

jPointToLayer <- "#! function(feature, latlng){
 return L.circleMarker(latlng, {radius: 3})
} !#"