#!/bin/bash

mkdir /downloads/.session && mkdir /downloads/watch && chown rtorrent:rtorrent /downloads/.session /downloads/watch && cp /downloads/.htpasswd /var/www/rutorrent/

rm -f /downloads/.session/rtorrent.lock

rm -f /etc/nginx/sites-enabled/*

site=rutorrent-insecure.nginx

if [ -e /downloads/.htpasswd ]; then
cp /downloads/.htpasswd /var/www/rutorrent/ && chmod 755 /var/www/rutorrent/.htpasswd && chown www-data:www-data /var/www/rutorrent/.htpasswd
site=rutorrent-basic.nginx
fi

#if [ -e /downloads/.secure ]; then
#else
#fi

cp /root/$site /etc/nginx/sites-enabled/

nginx -g "daemon off;"

