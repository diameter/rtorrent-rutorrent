FROM ubuntu:xenial
USER root

# add extra sources 
ADD ./extra.list /etc/apt/sources.list.d/extra.list

# install
RUN apt-get update && \
    apt-get install -y --force-yes rtorrent unzip unrar mediainfo curl php5-fpm php5-cli php5-geoip nginx wget ffmpeg supervisor && \
    rm -rf /var/lib/apt/lists/*

# configure nginx
ADD rutorrent-*.nginx /root/

# download rutorrent
RUN mkdir -p /var/www && \
    wget --no-check-certificate https://bintray.com/artifact/download/novik65/generic/ruTorrent-3.7.zip && \
    unzip ruTorrent-3.7.zip && \
    mv ruTorrent-master /var/www/rutorrent && \
    rm ruTorrent-3.7.zip
ADD ./config.php /var/www/rutorrent/conf/

# add startup scripts and configs
ADD startup-rtorrent.sh startup-nginx.sh startup-php.sh .rtorrent.rc /root/

# configure supervisor
ADD supervisord.conf /etc/supervisor/conf.d/

EXPOSE 80,443,49160,49161
VOLUME /downloads

CMD ["supervisord"]

