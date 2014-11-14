#!/bin/bash
#docker rm rutorrent rtorrent
docker run -d --name rutorrent -p 8080:80 local/rutorrent:1
docker run -dt --name rtorrent --net="container:rutorrent" -v ~/test:/downloads local/rtorrent:1

