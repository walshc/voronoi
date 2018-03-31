# voronoi
An `R` package to find which regions each region in a shapefile is adjacent to. Outputs a `data.frame` and (optionally) the adjacency matrix and a plot of the adjacencies. This is useful, for example, if you only have the centroids of various areas and not the corresponding shapefile. The voronoi diagram can serve as an approximation.

## Installation

```r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("walshc/voronoi")
```

## Example Usage
Download, extract and load a shapefile of US states:
```r
file <- "http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_20m.zip"
download.file(file, "states.zip")
unzip("states.zip")
shp <- rgdal::readOGR(".", "cb_2015_us_state_20m")
shp <- shp[!(shp@data$STATEFP %in% c("02", "15", "72")),]  # Contiguous US
shp <- sp::spTransform(shp, CRS("+init=epsg:26978"))
```
For some example points, use the centroids of the states:
```r
crds <- sp::coordinates(shp)
```
To use the function, give it the longitudes, latitudes and the bounding shapefile:
```r
voronoi <- voronoiShapefile(lon = crds[, 1], lat = crds[, 2], shp = shp)
```
You can export the shapefile as follows:
```r
rgdal::writeOGR(voronoi, dsn = ".", driver = "ESRI Shapefile",
                layer = "voronoi-states", overwrite_layer = TRUE)
```
The resulting shapefile looks like this:
<div align="center">
<img src="https://github.com/walshc/voronoi/blob/master/example.png?raw=true" width="700">
</div>

