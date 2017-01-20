output$myMap <- renderMap({

  if (!is.null(p$species)) {
    print(p$species)
    dat <- DAT[which(DAT$name_c == p$species), ]
  } else {
    dat <- DAT[which(DAT$name_c == input$iSpecies), ]
  }
  
  ## Map;
  m <- Leaflet$new()
  m$addParams(width="100%", height=1000,
              layerOpts = list(maxZoom = 18))
  # if (!is.null(input$mapType)) {
  #   if (input$mapType == "normal") {
  #     m$addParams(chinamap = "TianDiTu.Normal.Map")
  #   } else if (input$mapType == "satellite") {
  #     m$addParams(chinamap = "TianDiTu.Satellite.Map")
  #   } else if (input$mapType == "terrain") {
  #     m$addParams(chinamap = "TianDiTu.Terrain.Map")
  #   }
  # }
  # 
  



  if (nrow(dat) > 0) {
    m$addParams(bounds = list(c(min(dat$lat)-3,min(dat$lon)-3),
                              c(max(dat$lat)+3,max(dat$lon)+3)))
    L <- SpatialPointsDataFrame(coords = dat[, c("lon", "lat")], 
                                data = data.frame(Name = dat$name_e),
                                proj4string = CRS("+proj=longlat +datum=WGS84"))
    ## Build GeoJSON list;
    Dat <- list()
    ## Deepest layer;
    if (input$boxLevel == TRUE & input$iLevel > 0) {
      den <- kernelUD(L[,1])
      d50 <- getverticeshr(den, percent = as.numeric(input$iLevel))
      d50 <- slot(slot(d50, "polygons")[[1]], "Polygons")
      length(d50)
      
#       for (N in seq(-30,0, 0.1)) {
        
        d50.array <- list(rep(NA, length(d50)))
        for (f in 1:length(d50)) {
          d50.f <- slot(d50[[f]], "coords")
          d50.f.ls <- list(rep(NA, nrow(d50.f)))
          for (i in 1:nrow(d50.f)) d50.f.ls[[i]] <- c(d50.f[i, 1], d50.f[i, 2])
          d50.array[[f]] <- d50.f.ls
        } 
        geoList <- list(type = "Feature", 
                        geometry = list(type = "MultiPolygon",coordinates = list(d50.array)),
                        properties = list(color = "green", 
                                          fillColor = "green",
                                          weight = 1,
                                          fillOpacity = 0.2,
                                          popup = "Kernel Density"))  
        Dat[[length(Dat)+1L]] <- geoList
#       }
      
#       for (f in 1:length(d50)) {
#         d50.f <- slot(d50[[f]], "coords")
#         d50.f.ls <- list(rep(NA, nrow(d50.f)))
#         for (i in 1:nrow(d50.f)) d50.f.ls[[i]] <- c(d50.f[i, 1], d50.f[i, 2])
#         
#         geoList <- list(type = "Feature", 
#                         geometry = list(type = "Polygon",coordinates = list(d50.f.ls)),
#                         properties = list(color = "green", 
#                                           fillColor = "green",
#                                           weight = 1,
#                                           fillOpacity = 0.2,
#                                           popup = "Kernel Density"))  
#         Dat[[length(Dat)+1L]] <- geoList
#       }
    }
    
    ## Middel layer;
    if (input$boxPercent == TRUE & input$iPercent >=0) {
      mcp <- mcp(L[,1], percent = as.numeric(input$iPercent))
      mcp <- slot(slot(slot(mcp, "polygons")[[1]], "Polygons")[[1]], "coords")
      mcp.ls <- list(rep(NA, nrow(mcp)))
      for (i in 1:nrow(mcp)) mcp.ls[[i]] <- c(mcp[i, 1], mcp[i, 2])
      geoList <- list(type = "Feature", 
                      geometry = list(type = "Polygon", coordinates = list(mcp.ls)),
                      properties = list(color = "red", 
                                        fillColor = "red",
                                        weight = 5,
                                        fillOpacity = 0,
                                        popup = "Minimum Convex Polygon"))
      Dat[[length(Dat)+1L]] <- geoList
    }
    # Point;
    for (i in 1:nrow(dat)) {
      geoList <- list(type = "Feature", 
                      geometry = list(type = "Point", coordinates = c(dat$lon[i], dat$lat[i])),
                      properties = list(color = "blue", 
                                        fillColor = "blue",
                                        fillOpacity = 1, 
                                        weight = 1,
                                        popup = paste(dat[i, ],  collapse = "<br>")))
      Dat[[length(Dat)+1L]] <- geoList
    }
    
    m$geoJson(Dat, onEachFeature = jOnEachFeature,
              style = jStyle, pointToLayer =jPointToLayer)
    

  }

m
})