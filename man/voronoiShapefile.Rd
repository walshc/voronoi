\name{voronoiShapefile}
\alias{voronoiShapefile}
\title{Create a shapefile/spatialPoints of the Voronoi diagram of given points.}
\description{Create a shapefile/spatialPoints of the Voronoi diagram of given
points.}
\usage{
voronoiShapefile(lon, lat, shp)
}
\arguments{
  \item{lon}{A vector of longitudes}
  \item{lat}{A vector of latitudes}
  \item{shp}{A \code{SpatialPolygonsDataFrame} surrounding where the points lie.}
}
\value{
  Returns a \code{SpatialPolygons} of the voronoi diagram of the points, intersected with the given shapefile.}
\examples{
# Get a shapefile of US States:
file <- "http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_20m.zip"
download.file(file, "states.zip")
unzip("states.zip")
shp <- rgdal::readOGR(".", "cb_2015_us_state_20m")
shp <- shp[shp@data$STATEFP != "02", ]
shp <- shp[shp@data$STATEFP != "15", ]
shp <- shp[shp@data$STATEFP != "72", ]
shp <- sp::spTransform(shp, sp::CRS("+init=epsg:26978"))
crds <- sp::coordinates(shp)
voronoi <- voronoiShapefile(crds[, 1], crds[, 2], shp = shp)
plot(voronoi)
}

