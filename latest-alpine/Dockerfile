FROM alpine:3.10
USER root

# php-geoip left out
RUN apk add --no-cache rtorrent mediainfo unzip unrar curl php7-fpm php7 php7-json php7-zip nginx wget ffmpeg supervisor git sox irssi && \
    apk add --no-cache py-pip gcc g++ python-dev musl-dev libffi-dev openssl-dev && \
    pip install cloudscraper && \
    apk del py-pip gcc g++ python-dev musl-dev libffi-dev openssl-dev && \
    git clone -b alpine https://github.com/diameter/rtorrent-rutorrent-shared.git a && \
    mkdir -p /var/www && cd /var/www && \
    git clone https://github.com/Novik/ruTorrent.git rutorrent && \
    rm -rf ./rutorrent/.git* && cd / && \
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
