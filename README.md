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
 - rtorrent scratch files (watch and .session will be created automatically): /downloads

----------
Adding basic auth:

Put .htpasswd into your /downloads volume root, the container will re-read .htpasswd each time it starts. To remote auth, simply remove .htpasswd and restart your container.

Instructions on how to generate .htpasswd can be found here: http://wiki.nginx.org/Faq#How_do_I_generate_an_htpasswd_file_without_having_Apache_tools_installed.3F

    $ printf "John:$(openssl passwd -crypt V3Ry)\n" >> .htpasswd # this example uses crypt encryption

    $ printf "Mary:$(openssl passwd -apr1 SEcRe7)\n" >> .htpasswd # this example uses apr1 (Apache MD5) encryption

    $ printf "Jane:$(openssl passwd -1 V3RySEcRe7)\n" >> .htpasswd # this example uses MD5 encryption

    $ PASSWORD="SEcRe7PwD";SALT="$(openssl rand -base64 3)";SHA1=$(printf "$PASSWORD$SALT" | openssl dgst -binary -sha1 | sed 's#$#'"$SALT"'#' | base64);printf "Jim:{SSHA}$SHA1\n" >> .htpasswd) # this example uses SSHA encryption


----------
Example, 64-bit:

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:19161 -v ~/test:/downloads diameter/rtorrent-rutorrent:64

Example, 32-bit:

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:19161 -v ~/test:/downloads diameter/rtorrent-rutorrent:32

----------
Access web-interface: enter your_ip:8080 in a browser
