FROM ubuntu
USER root

# add ffmpeg ppa
ADD ./ffmpeg-next.list /etc/apt/sources.list.d/ffmpeg-next.list

# install
RUN apt-get update && \
    apt-get install -y --force-yes rtorrent unzip unrar mediainfo curl php5-fpm php5-cli php5-geoip nginx wget ffmpeg supervisor && \
    rm -rf /var/lib/apt/lists/*

# configure nginx
ADD rutorrent-*.nginx /root/

# download rutorrent
RUN mkdir -p /var/www/rutorrent && wget http://dl.bintray.com/novik65/generic/rutorrent-3.6.tar.gz && \
    wget http://dl.bintray.com/novik65/generic/plugins-3.6.tar.gz && \
    tar xvf rutorrent-3.6.tar.gz -C /var/www && \
    tar xvf plugins-3.6.tar.gz -C /var/www/rutorrent && \
    rm *.gz
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

