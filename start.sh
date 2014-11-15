#!/bin/bash
cd /home/rtorrent
rtorrent &
php5-fpm
nginx -g "daemon off;"

