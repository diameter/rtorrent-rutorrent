FROM i386/alpine:3.3
USER root

# mediainfo and php-geoip left out
RUN apk add --no-cache rtorrent unzip unrar curl php-fpm php-cli php-json nginx wget ffmpeg supervisor git && \
    git clone -b alpine https://github.com/diameter/rtorrent-rutorrent-shared.git a && \
    mkdir -p /var/www && \
    wget --no-check-certificate https://bintray.com/artifact/download/novik65/generic/ruTorrent-3.7.zip && \
    unzip ruTorrent-3.7.zip && \
    mv ruTorrent-master /var/www/rutorrent && \
    rm ruTorrent-3.7.zip && \
    cp ./a/config.php /var/www/rutorrent/conf/ && \
    cp ./a/startup-rtorrent.sh ./a/startup-nginx.sh ./a/startup-php.sh ./a/.rtorrent.rc /root/ && \
    mkdir -p /etc/supervisor.d && \
    cp ./a/supervisord.conf /etc/supervisor.d/supervisord.ini && \
    mkdir -p /etc/nginx/sites-enabled && \
    cp ./a/nginx.conf /etc/nginx/ && \
    cp ./a/php-fpm.conf /etc/php/ && \
    cp ./a/rutorrent-*.nginx /root/

EXPOSE 80 443 49160 49161
VOLUME /downloads

CMD ["supervisord"]

