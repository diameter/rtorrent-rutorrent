FROM 32bit/ubuntu:14.04
USER root

# add ffmpeg ppa
ADD ./jon-severinsson-ffmpeg-trusty.list /etc/apt/sources.list.d/jon-severinsson-ffmpeg-trusty.list

# install
RUN apt-get update && \
    apt-get install -y --force-yes rtorrent unzip unrar-free mediainfo curl php5-fpm php5-cli php5-geoip nginx wget ffmpeg supervisor && \
    rm -rf /var/lib/apt/lists/*

# configure nginx
ADD rutorrent.nginx /etc/nginx/sites-available/rutorrent
RUN ln -s /etc/nginx/sites-available/rutorrent /etc/nginx/sites-enabled/ && rm /etc/nginx/sites-available/default

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
RUN chown -R rtorrent:rtorrent /home/rtorrent && mkdir -p /home/rtorrent/.session && \
    mkdir -p /home/rtorrent/watch && chown -R rtorrent:rtorrent /home/rtorrent

# configure supervisor
ADD supervisord.conf /etc/supervisor/conf.d/

EXPOSE 80
EXPOSE 49160
EXPOSE 49161
VOLUME /downloads

CMD ["supervisord"]

