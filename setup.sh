#!/bin/bash

set -e

# Unzip shapefiles into shapefiles directory
SHAPEFILES_SRC="/usr/share/shapefiles-src"
SHAPEFILES_DIR="/usr/local/share/maps/style/osm-bright-master/shp"
mkdir -p $SHAPEFILES_DIR

ls $SHAPEFILES_SRC

unzip $SHAPEFILES_SRC/simplified-land-polygons-complete-3857.zip -d $SHAPEFILES_DIR
unzip $SHAPEFILES_SRC/land-polygons-split-3857.zip -d $SHAPEFILES_DIR
unzip $SHAPEFILES_SRC/ne_10m_populated_places_simple.zip -d $SHAPEFILES_DIR/ne_10m_populated_places_simple

# Add spatial indexes to shapefiles
cd $SHAPEFILES_DIR/land-polygons-split-3857
shapeindex land_polygons.shp

cd $SHAPEFILES_DIR/simplified-land-polygons-complete-3857
shapeindex simplified_land_polygons.shp

cd /usr/local/share/maps/style/osm-bright-master
./make.py

cd ../OSMBright
carto project.mml > OSMBright.xml

chmod +x /etc/end.sh
/bin/bash /etc/end.sh
