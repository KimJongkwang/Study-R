# GIS R Packages

GIS(Geographic Information System, 지리정보시스템)은 흔히 지도 데이터로써 통용되며, 위치속성이 포함된 정보 데이터라 생각됩니다.

GIS는 보통 `위치정보를 가진 공간자료`와 `공간의 속성을 담은 속성자료`를 가지고 있습니다.

데이터의 형태로는 크게 벡터(vector)와 래스터(raster)로 구분됩니다.
- 벡터(vector) : 점(point), 선(line), 면(polygon)으로 이루어진 레이어
    - shp, geojson, kml, gml 등의 포맷
- 래스터(raster) : 그리드(grid) 또는 픽셀(pixel) 단위의 이미지 레이어
    - img, tiff, jpeg2000 등과 같이 이미지 또는 영상의 파일 포맷

> https://ko.wikipedia.org/wiki/%EC%A7%80%EB%A6%AC_%EC%A0%95%EB%B3%B4_%EC%8B%9C%EC%8A%A4%ED%85%9C

## Pre-requirements

위의 GIS를 다루기 위해 R에서는 rgdal, raster, sp, sf 등 여러 패키지를 제공합니다.

하지만, 위 공간정보를 다루는 패키지를 R에서 사용하기 위해 소프트웨어를 선행하여 설치를 해야합니다.

대표적으로 GDAL과 PROJ가 있습니다.

온라인 환경에서는 설치가 비교적 수월합니다. GDAL 설치는 아래에서 확인 가능합니다. PROJ는 GDAL과 의존되어 설치됩니다.
> https://gis.stackexchange.com/questions/120101/building-gdal-with-libkml-support/120103#120103

이외에도 sqlite, ncl, jdk 등의 부가 소프트웨어를 필요로 합니다. *(폐쇄망에서 설치를 해야한다면 꼼꼼히 찾아서 가야합니다..)*

위의 소프트웨어는 R 패키지 뿐만 아니라 python 공간처리 패키지, 더 나아가 PostGIS 등 거의 대다수의 공간정보 툴에 필요로 합니다.

## Index

- vector-data-processing
- raster
- sf, sp
----------------------------------

