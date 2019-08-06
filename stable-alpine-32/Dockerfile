FROM i386/alpine:3.10
USER root

# php-geoip left out
RUN apk add --no-cache rtorrent mediainfo unzip unrar curl php7-fpm php7 php7-json nginx wget ffmpeg supervisor git sox irssi py-pip && \
    pip install cfscrape && \
    ln -s /bin/stat /usr/bin && \
    git clone -b alpine https://github.com/diameter/rtorrent-rutorrent-shared.git a && \
    mkdir -p /var/www && \
    wget --no-check-certificate https://github.com/Novik/ruTorrent/archive/v3.9.tar.gz && \
    tar xzf v3.9.tar.gz && \
    mv ruTorrent-3.9 /var/www/rutorrent && \
    rm v3.9.tar.gz && \
    cp ./a/config.php /var/www/rutorrent/conf/ && \
    cp ./a/startup-rtorrent.sh ./a/startup-nginx.sh ./a/startup-php.sh ./a/.rtorrent.rc /root/ && \
    mkdir -p /etc/supervisor.d && \
    cp ./a/supervisord.conf /etc/supervisor.d/supervisord.ini && \
    mkdir -p /etc/nginx/sites-enabled && \
    cp ./a/nginx.conf /etc/nginx/ && \
    cp ./a/php-fpm.conf /etc/php7/ && \
    cp ./a/rutorrent-*.nginx /root/

EXPOSE 80 443 49160 49161
VOLUME /downloads

CMD ["supervisord"]

