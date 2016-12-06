FROM ioft/i386-ubuntu:xenial
USER root

RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/diameter/rtorrent-rutorrent-shared.git a && \
    cp ./a/extra.list /etc/apt/sources.list.d/extra.list && \
    apt-get update && \
    apt-get install -y rtorrent unzip unrar mediainfo curl php-fpm php-cli php-geoip nginx wget ffmpeg supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    cp ./a/rutorrent-*.nginx /root/ && \
    mkdir -p /var/www && cd /var/www && \
    git clone https://github.com/Novik/ruTorrent.git rutorrent && \
    rm -rf ./rutorrent/.git* && cd / && \
    cp ./a/config.php /var/www/rutorrent/conf/ && \
    cp ./a/startup-rtorrent.sh ./a/startup-nginx.sh ./a/startup-php.sh ./a/.rtorrent.rc /root/ && \
    cp ./a/supervisord.conf /etc/supervisor/conf.d/

EXPOSE 80 443 49160 49161
VOLUME /downloads

CMD ["supervisord"]

