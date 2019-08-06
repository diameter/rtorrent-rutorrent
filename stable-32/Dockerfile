FROM i386/ubuntu
USER root

RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/diameter/rtorrent-rutorrent-shared.git a && \
    cp ./a/extra.list /etc/apt/sources.list.d/extra.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rtorrent tar gzip unzip unrar mediainfo curl php-fpm php-cli php-geoip nginx wget ffmpeg supervisor php-xml libarchive-zip-perl libjson-perl libxml-libxml-perl irssi sox python-pip libssl-dev && \
    pip install cloudscraper cfscrape && \
    rm -rf /var/lib/apt/lists/* && \
    cp ./a/rutorrent-*.nginx /root/ && \
    mkdir -p /var/www && \
    wget --no-check-certificate https://github.com/Novik/ruTorrent/archive/v3.9.tar.gz && \
    tar xzf v3.9.tar.gz && \
    mv ruTorrent-3.9 /var/www/rutorrent && \
    rm v3.9.tar.gz && \
    cp ./a/config.php /var/www/rutorrent/conf/ && \
    cp ./a/startup-rtorrent.sh ./a/startup-nginx.sh ./a/startup-php.sh ./a/startup-irssi.sh ./a/.rtorrent.rc /root/ && \
    cp ./a/supervisord.conf /etc/supervisor/conf.d/ && \
    sed -i 's/\/var\/log/\/downloads\/\.log/g' /etc/nginx/nginx.conf


EXPOSE 80 443 49160 49161
VOLUME /downloads

CMD ["supervisord"]

