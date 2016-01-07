FROM 32bit/ubuntu:14.04
USER root

# add ffmpeg ppa
ADD ./ffmpeg-next.list /etc/apt/sources.list.d/ffmpeg-next.list

# install
RUN apt-get update && \
    apt-get install -y --force-yes rtorrent unzip unrar-free mediainfo curl php5-fpm php5-cli php5-geoip nginx wget ffmpeg supervisor git-core && \
    rm -rf /var/lib/apt/lists/*

# configure nginx
ADD rutorrent-*.nginx /root/

# download rutorrent
RUN mkdir -p /var/www/ && cd /var/www && \
    git clone https://github.com/Novik/ruTorrent.git rutorrent && \
    rm -rf ./rutorrent/.git*
ADD ./config.php /var/www/rutorrent/conf/
RUN chown -R www-data:www-data /var/www/rutorrent

# configure rtorrent
RUN useradd -d /home/rtorrent -m -s /bin/bash rtorrent
ADD .rtorrent.rc /home/rtorrent/
RUN chown -R rtorrent:rtorrent /home/rtorrent

# add startup script
ADD startup.sh /root/

# configure supervisor
ADD supervisord.conf /etc/supervisor/conf.d/

EXPOSE 80
EXPOSE 443
EXPOSE 49160
EXPOSE 49161
VOLUME /downloads

CMD ["supervisord"]
