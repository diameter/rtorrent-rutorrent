FROM 32bit/ubuntu:14.04
#FROM ubuntu
USER root

RUN apt-get update 
RUN apt-get install -y rtorrent unzip unrar-free mediainfo curl php5-fpm php5-cli php5-geoip 

RUN rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/rtorrent -m -s /bin/bash rtorrent

VOLUME /downloads
#EXPOSE 5000
#EXPOSE 80

USER rtorrent
RUN mkdir /home/rtorrent/.session
RUN mkdir /home/rtorrent/watch
ADD .rtorrent.rc /home/rtorrent/

WORKDIR /home/rtorrent
ENTRYPOINT ["/usr/bin/rtorrent"]

