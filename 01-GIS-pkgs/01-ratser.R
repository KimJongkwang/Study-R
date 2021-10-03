library(raster)

# raster 데이터 로드 및 요약
max_temp <- raster('./data-files/max_temperature.img')

######
#class      : RasterLayer
#dimensions : 556, 546, 303576  (nrow, ncol, ncell)
#resolution : 1000, 1000  (x, y)
#extent     : 754646.1, 1300646, 1472656, 2028656  (xmin, xmax, ymin, ymax)
#crs        : +proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs
#source     : /home/kjk/study-R/01-GIS-pkgs/data-files/max_temperature.img
#names      : max_temperature
#values     : 24.2002, 33.19905  (min, max)

#print(max_temp)

#attribute of raster
class(max_temp)
dim(max_temp) #dimensions
nrow(max_temp) #rows of raster
ncol(max_temp) #cols of raster
ncell(max_temp) #count of cells

crs(max_temp) #coordinates reference system

# 등록된 좌표정보
coordinates <- coordinates(max_temp) #x, y matrix
x <- coordinates[, 1] #x
y <- coordinates[, 2] #y
head(coordinates)
head(x)
head(y)

# Extract values from Raster objects
# raster::extract(x, y, *args...)
"""
x = Raster object
y = points represented by a two-column matrix or data.frame, 
    or SpatialPoints*; SpatialPolygons*; SpatialLines; sf spatial vector objects; Extent; 
    or a numeric vector representing cell numbers
"""
## extract
extract(max_temp, max_temp_df, fun=z)