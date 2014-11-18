Docker container with rTorrent and ruTorrent
============================================

Multiple processes inside the container managed by supervisor:
supervisord-+-nginx
            |-php5-fpm
            `-rtorrent

Exposed:
 - Web UI port: 80
 - DHT UDP port: 49160
 - Incoming connections port: 49161
 - Downloads volume: /downloads

Example:
$ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:19161 -v ~/test:/downloads diameter/rtorrent-rutorrent:64

