FROM 32bit/ubuntu:14.04
#FROM ubuntu
USER root

RUN apt-get update 
RUN apt-get install -y rtorrent unzip unrar-free mediainfo curl php5-fpm php5-cli php5-geoip nginx wget supervisor
RUN rm -rf /var/lib/apt/lists/*


USER root
RUN mkdir -p /var/www/rutorrent
ADD rutorrent.nginx /etc/nginx/sites-available/rutorrent
RUN ln -s /etc/nginx/sites-available/rutorrent /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-available/default

RUN wget http://dl.bintray.com/novik65/generic/rutorrent-3.6.tar.gz
RUN wget http://dl.bintray.com/novik65/generic/plugins-3.6.tar.gz
RUN tar xvf rutorrent-3.6.tar.gz -C /var/www
RUN tar xvf plugins-3.6.tar.gz -C /var/www/rutorrent
RUN rm *.gz

RUN chown -R www-data:www-data /var/www/rutorrent
EXPOSE 80

ADD supervisord.conf /etc/supervisor/conf.d/

RUN useradd -d /home/rtorrent -m -s /bin/bash rtorrent

VOLUME /downloads

ADD .rtorrent.rc /home/rtorrent/
RUN chown rtorrent:rtorrent /home/rtorrent/.rtorrent.rc

USER rtorrent
RUN mkdir /home/rtorrent/.session
RUN mkdir /home/rtorrent/watch

EXPOSE 49160
EXPOSE 49161

USER root
CMD ["supervisord"]


