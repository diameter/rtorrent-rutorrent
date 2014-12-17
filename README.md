Docker container with rTorrent and ruTorrent
============================================

Multiple processes inside the container managed by supervisor:

- nginx
- php5-fpm
- rtorrent

----------
Exposed:

 - Web UI port: 80
 - DHT UDP port: 49160
 - Incoming connections port: 49161
 - Downloads volume: /downloads

----------
Example, 64-bit:

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:19161 -v ~/test:/downloads diameter/rtorrent-rutorrent:64

Example, 32-bit:

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:19161 -v ~/test:/downloads diameter/rtorrent-rutorrent:32

----------
Access web-interface: enter your_ip:8080 in a browser
