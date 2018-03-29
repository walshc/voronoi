voronoiShapefile <- function(lon, lat, shp) {
  if (length(shp) > 1) {
    shp <- unionSpatialPolygons(shp, rep(1, length(shp)))
  }
  z <- tile.list(deldir::deldir(lon, lat, rw = c(t(shp@bbox))))
  poly <- SpatialPolygons(lapply(seq_along(z), function(i) {
    pcrds <- cbind(z[[i]]$x, z[[i]]$y)
    pcrds <- rbind(pcrds, pcrds[1, ])
    return(Polygons(list(Polygon(pcrds)), ID = i))
  }), proj4string = CRS(proj4string(shp)))
  poly <- intersect(poly, shp)
  data <- data.frame(id = seq_along(z))
  row.names(poly) <- paste(data$id)
  return(SpatialPolygonsDataFrame(poly, data = data))
}
