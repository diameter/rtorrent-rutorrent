#!/bin/bash

mkdir /downloads/.session 
mkdir /downloads/watch 
chown rtorrent:rtorrent /downloads/.session /downloads/watch 
cp /downloads/.htpasswd /var/www/rutorrent/
mkdir -p /downloads/config/torrents 
chown -R www-data:www-data /downloads/config

rm -f /downloads/.session/rtorrent.lock

rm -f /etc/nginx/sites-enabled/*

rm -rf /etc/nginx/ssl

rm /var/www/rutorrent/.htpasswd

# Basic auth enabled by default
site=rutorrent-basic.nginx

# Check if TLS needed
if [[ -e /downloads/nginx.key && -e /downloads/nginx.crt ]]; then
mkdir -p /etc/nginx/ssl
cp /downloads/nginx.crt /etc/nginx/ssl/
cp /downloads/nginx.key /etc/nginx/ssl/
site=rutorrent-tls.nginx
fi

cp /root/$site /etc/nginx/sites-enabled/

# Check if .htpasswd presents
if [ -e /downloads/.htpasswd ]; then
cp /downloads/.htpasswd /var/www/rutorrent/ && chmod 755 /var/www/rutorrent/.htpasswd && chown www-data:www-data /var/www/rutorrent/.htpasswd
else
# disable basic auth
sed -i 's/auth_basic/#auth_basic/g' /etc/nginx/sites-enabled/$site
fi

if [ ! -z $MEMORY_LIMIT ]; then
  sed -i 's/^memory_limit.*//' /etc/php5/fpm/php.ini
  echo "memory_limit = ${MEMORY_LIMIT}M" >> /etc/php5/fpm/php.ini
fi

nginx -g "daemon off;"

