
/*
$(document).ready(function(){
  $("img#layers").mouseover(function(){
    $("div.layers").attr("style", "visibility: visible;");
    $("img#layers").attr("style", "visibility: hidden;");
  });
  $('div.layers').mouseleave(function(){
    $("div.layers").attr("style", "visibility: hidden;");
    $("img#layers").attr("style", "visibility: visible;");
  });
})

*/





// IP info;
$(document).ready(function(){
  var l = $("#log");
  $.get("http://ipinfo.io", function(e) {
    l.val(Date() + "  ipInfo|" + e.ip + "," + e.city + "," + e.loc);
    l.trigger("change");
  }, "jsonp");
});

/*
$(document).ready(function(){
  $("img#control").mouseover(function(){
    $("div.control").attr("style", "visibility: visible;");
    $("img#control").attr("style", "visibility: hidden;");
  });
  $('div.control').mouseleave(function(){
    $("div.control").attr("style", "visibility: hidden;");
    $("img#control").attr("style", "visibility: visible;");
  });
})
*/

var e2c = {
  " Normal (TianDiTu)"   : "地图（天地图）",
  " Normal (GaoDe)"      : "地图（高德）",
  " Satellite (TianDiTu)": "卫星（天地图）",
  " Satellite (GaoDe)"   : "卫星（高德）",
  " Terrain (TianDiTu)"  : "地形（天地图）"
};

var c2e = {
  "地图（天地图）": " Normal (TianDiTu)",
  "地图（高德）"  : " Normal (GaoDe)",
  "卫星（天地图）": " Satellite (TianDiTu)",
  "卫星（高德）"  : " Satellite (GaoDe)",
  "地形（天地图）": " Terrain (TianDiTu)"
};

$(document).ready(function(){
  $("#lang1").click(function(){
    var e = $("*", ".leaflet-control-layers-base");
    for(var i = 0; i < e.length; i++) {
      if(e[i].children.length === 0 && e[i].textContent.replace(/ |\n/g,'') !== '') {
        if (c2e.hasOwnProperty(e[i].textContent)) {
          e[i].textContent = c2e[e[i].textContent];
        }
      }
    }; 
  })
})

$(document).ready(function(){
  $("#lang2").click(function(){
    var e = $("*", ".leaflet-control-layers-base");
    for(var i = 0; i < e.length; i++) {
      if(e[i].children.length === 0 && e[i].textContent.replace(/ |\n/g,'') !== '') {
        if (e2c.hasOwnProperty(e[i].textContent)) {
          e[i].textContent = e2c[e[i].textContent];
        }
      }
    }; 
  })
})


