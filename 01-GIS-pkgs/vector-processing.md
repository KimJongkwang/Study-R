
# vector-data-processing

## Index
- 기본 기능
    - 벡터 레이어 읽기
    - 벡터 레이어 구조(sp)
    - 좌표계 변환
    - 속성정보 추가하기

- 공간 처리 기능

## 기본 기능

### 벡터 레이어 읽기

벡터 레이어를 불러올때는 `rgdal::readOGR()`를 사용합니다.

use_iconv 옵션을 TRUE를 줄 시에는 encoding 옵션의 encoding을 시스템 encoding으로 변환시켜줍니다. 

즉, 한글이 깨지지 않도록 설정해줍니다.

```R
library(rgdal)

shp <- readOGR("sc_grid.shp", use_iconv=TRUE, encoding='UTF-8')
# shp <- readOGR(dsn=".", layer="sc_grid", use_iconv=TRUE, encoding='UTF-8')>
```

### 벡터 레이어 구조
```R
class(shp)
```
class로 확인해보면, "SpatialPolygonsDataFrame" 즉 면자료로 확인이 되며, `sp` 객체로 나타났습니다.

`sp`객체와 `sf`객체는 추후 정리해보겠습니다.

```SHELL
[1] "SpatialPolygonsDataFrame"
attr(,"package")
[1] "sp"
```

```
str(shp)
```
str로 구조를 확인하면, sp 데이터에는 @ 로 구분된 slot이 있습니다. slot은 아래와 같습니다.
 - @ data : 데이터의 정보 즉, 속성정보가 담겨있는 data.frame 입니다.
 - @ polygons : 레이어에 포함된 각각의 폴리곤들의 정보가 담겨있습니다.
    - 위의 구조는 json과 유사하게, 중첩된 key value로 구성되어 있습니다.
 - @ plotOrder : 폴리곤의 index id 정보입니다.
 - @ bbox : bounding box로 레이어를 둘러싼 좌표 및 데이터 차원을 나타내는 것으로 보입니다. 추후 필요하다면 더 알아보겠습니다.
 - @ proj4string : CRS class로 레이어의 좌표계입니다.


### 좌표계 변환

GIS 자료를 처리할 경우 기본으로 사용하는 기능이라고 생각됩니다. 단일 자료만을 분석한다면 상관없겠지만, 다수의 공간자료를 처리할 때 좌표를 맞추어야 공간적인 처리가 가능합니다.

위에서 정의한 `shp` 레이어는 UTM-K 좌표계였습니다(EPSG:5179).
아래에서 WGS84의 경위도 좌표계로 변경하겠습니다(EPSG:4326).
```
shp_4326 <- spTransform(shp,CRS("+proj=longlat +ellps=WGS84 +datum=WGS84"))
```

### 속성정보 추가하기

벡터 레이어에 속성정보를 추가할 수 있습니다. 

위에서 @ data가 data.frame class로 되어 있는 것을 확인했습니다.

일반적으로 data.frame에 컬럼을 추가하는 방식으로 @ data에 속성정보를 추가할 수 있습니다.

```
shp@data$new_val <- 0
```
----------------------------


