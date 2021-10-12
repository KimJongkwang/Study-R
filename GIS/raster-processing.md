
# raster-data-processing

## Index
- 기본 기능
    - 래스터 레이어 읽기
    - 래스터 레이어 구조(sp)
    - 좌표계 변환
    - 래스터 값 추출하기

- 공간처리
    - 공간상세화(up-scaling)
    - 

## 기본 기능

### 래스터 레이어 읽기

래스터 레이어는 `raster::raster()`를 사용합니다.
```R
library(raster)

raster(max_temperature.img)
```

### 래스터 레이어 구조

raster('raster file')로 데이터를 읽게 되면, 래스터는 RasterLayer 클래스로 정의됩니다.

또한 불러오게 되었을 때, 아래와 같이 출력이 됩니다. 또한, 벡터와 동일하게 str 함수로 slot을 확인 할 수 있습니다. 

```
class      : RasterLayer  # 데이터 클래스
dimensions : 556, 546, 303576  (nrow, ncol, ncell) # 데이터 크기(행 개수, 열 개수, 셀 개수)
resolution : 1000, 1000  (x, y) # 각 셀의 해상도
extent     : 754646.1, 1300646, 1472656, 2028656  (xmin, xmax, ymin, ymax) # 데이터의 좌표 min, max(동서, 남북 끝 셀의 좌표값)
crs        : +proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs # 좌표체계
source     : /home/study-R/01-GIS-pkgs/data-files/max_temperature.img # 데이터 경로
names      : max_temperature # 데이터 파일명
values     : 24.2002, 33.19905  (min, max) # 데이터(band) 최솟값/최댓값
```

### 좌표 변환

래스터에서는 raster::projectRaster()를 사용 할 수 있습니다.
```R
raster::projectRaster("raster file", crs="+proj=longlat +ellps=WGS84 +datum=WGS84")
```

### 래스터 값 추출하기

값을 추출하는데는 `raster::extract()` 메서드를 사용합니다.
공식 문서에서 확인할 수 있듯이, 래스터 객체를 각 셀 중심 포인트에 해당하는 좌표값을 가진 매트릭스나 데이터프레임에 채워 넣을 수 있습니다.

```
Extract values from Raster objects
raster::extract(x, y, *args...)
x = Raster object
y = points represented by a two-column matrix or data.frame, 
    or SpatialPoints*; SpatialPolygons*; SpatialLines; sf spatial vector objects; Extent; 
    or a numeric vector representing cell numbers
```

```R
## extract
extract(max_temp, max_temp_df, fun=z)

```

## 공간처리

### 공간상세화(Up-Scaling)

공간상세화는 래스터 자료가 가진 고유해상도(픽셀 크기)를 더 작게 만들어 현실과 더 유사하게 상세화하는 것입니다. 

예를 들어 기존 래스터 자료가 가진 픽셀 10m x 10m에서 1m x 1m로 픽셀 크기를 바꾸어 준다는 것은 하나의 픽셀에 가로, 세로 10개의 픽셀을 더 추가해주는 것 인데, 이때 10개의 픽셀값을 어떻게 더욱 상세하게 해주냐(내삽)에 대한 문제가 있습니다.

다양한 방법이 있지만, 보간방법에 따라 사용 메서드가 달라집니다.

먼저 `raster::interpolate()` 메서드를 사용하는 예제를 보면 아래와 같습니다.

```R: interpolate() Method!!
## Thin plate spline model
library(raster)
library(fields) 
tps <- Tps(xy, v)
p <- raster(r)

# use model to predict values at all locations
p <- raster::interpolate(p, tps)
p <- mask(p, r)

## inverse distance weighted (IDW)
r <- raster("grid file", package="raster"))
data(meuse) # 내장 데이터셋
mg <- gstat(id = "zinc", formula = zinc~1, locations = ~x+y, data=meuse, 
            nmax=7, set=list(idp = .5))
z <- interpolate(r, mg)
z <- mask(z, r)

## kriging
coordinates(meuse) <- ~x+y
crs(meuse) <- crs(r)

## ordinary kriging
v <- variogram(log(zinc)~1, meuse)
m <- fit.variogram(v, vgm(1, "Sph", 300, 1))
gOK <- gstat(NULL, "log.zinc", log(zinc)~1, meuse, model=m)
OK <- interpolate(r, gOK)

## co-kriging
gCoK <- gstat(NULL, 'log.zinc', log(zinc)~1, meuse)
gCoK <- gstat(gCoK, 'elev', elev~1, meuse)
gCoK <- gstat(gCoK, 'cadmium', cadmium~1, meuse)
gCoK <- gstat(gCoK, 'copper', copper~1, meuse)
coV <- variogram(gCoK)
coV.fit <- fit.lmc(coV, gCoK, vgm(model='Sph', range=1000))
coV.fit
coK <- interpolate(r, coV.fit)
```

다음은 `raster::resample()` 메서드를 활용한 예제입니다.
```R: resample() Method!!
library(raster)
r <- raster(nrow=3, ncol=3)
values(r) <- 1:ncell(r)
s <- raster(nrow=10, ncol=10)
s <- resample(r, s, method='bilinear') # 이중선형보간
```

## refer 
> rdocumentation : https://www.rdocumentation.org/packages/raster/versions/3.4-13/topics/interpolate
> rdocumentation : https://www.rdocumentation.org/packages/raster/versions/3.4-13/topics/resample
