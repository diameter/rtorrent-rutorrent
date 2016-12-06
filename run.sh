#!/bin/bash
docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 443:443 -p 49160:49160/udp -p 49161:49161 -v ~/test/rtorrent:/downloads diameter/rtorrent-rutorrent:local

