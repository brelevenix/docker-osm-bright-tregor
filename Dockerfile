# DOCKER-VERSION 1.2.0
# VERSION 0.1

FROM vincentds1/mapnik
MAINTAINER James Badger <james@jamesbadger.ca>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y ca-certificates node-carto unzip wget

RUN mkdir -p /usr/local/share/maps/style
WORKDIR /usr/local/share/maps/style
RUN wget -q https://github.com/brelevenix/osm-bright-tregor/archive/master.zip &&\
    unzip master.zip &&\
    rm master.zip
    
# change directory name 
RUN mv osm-bright-tregor-master osm-bright-master

WORKDIR /usr/local/share/maps/style/osm-bright-master
COPY ./osm-bright.osm2pgsql.mml /usr/local/share/maps/style/osm-bright-master/osm-bright/osm-bright.osm2pgsql.mml
COPY ./configure.py /usr/local/share/maps/style/osm-bright-master/configure.py
COPY ./setup.sh /usr/local/share/maps/style/osm-bright-master/setup.sh
COPY ./renderd.conf /usr/local/share/maps/style/OSMBright/renderd.conf

ADD ./end.sh /etc/end.sh

VOLUME ["/usr/local/share/maps/style/OSMBright", "/usr/local/share/maps/style/osm-bright-master"]

ENTRYPOINT ["/usr/local/share/maps/style/osm-bright-master/setup.sh"]
