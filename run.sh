#!/bin/bash
docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 443:443 -p 49160:49160/udp -p 49161:19161 -v ~/test:/downloads diameter/rtorrent-rutorrent:64

