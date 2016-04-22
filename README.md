Docker container with rTorrent and ruTorrent (stable and latest from github)
============================================================================

Tags:
 
 - rtorrent-rutorrent:64 aka rtorrent-rutorrent:latest
 - rtorrent-rutorrent:64-latest
 - rtorrent-rutorrent:32
 - rtorrent-rutorrent:32-latest

----------

Multiple processes inside the container managed by supervisord:

- nginx
- php5-fpm
- rtorrent

----------
Exposed:

 - Web UI ports: 80 and 443
 - DHT UDP port: 49160
 - Incoming connections port: 49161
 - Downloads volume: /downloads
 - rtorrent scratch files (.rtorrent/{watch|session} will be created automatically): /downloads
 - external rtorrent config (.rtorrent/.rtorrent.rc): /downloads
 - external ruTorrent ui config (config will be created automatically): /downloads/.rutorrent
 - rtorrent uid and gid: USR_ID and GRP_ID env vars, default is 1000:1000
 - php5-fpm memory limit: PHP_MEM env var, default is 256M

----------
Adding basic auth:

Put .htpasswd into your /downloads volume root, the container will re-read .htpasswd each time it starts. To remote auth, simply remove .htpasswd and restart your container.

Instructions on how to generate .htpasswd can be found here: [Nginx FAQ][1] 

    $ printf "John:$(openssl passwd -crypt V3Ry)\n" >> .htpasswd # this example uses crypt encryption

    $ printf "Mary:$(openssl passwd -apr1 SEcRe7)\n" >> .htpasswd # this example uses apr1 (Apache MD5) encryption

    $ printf "Jane:$(openssl passwd -1 V3RySEcRe7)\n" >> .htpasswd # this example uses MD5 encryption

    $ PASSWORD="SEcRe7PwD";SALT="$(openssl rand -base64 3)";SHA1=$(printf "$PASSWORD$SALT" | openssl dgst -binary -sha1 | sed 's#$#'"$SALT"'#' | base64);printf "Jim:{SSHA}$SHA1\n" >> .htpasswd) # this example uses SSHA encryption

----------
Adding TLS:

Put your keyfile (shall be named nginx.key) and your certificate (nginx.crt) into /dowloads volume root, the container looks for these files each time it starts.

Generate a self-signed certificate:

    $ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt

Nginx TLS is configured as follwoing:

    keepalive_timeout   60;
    ssl_ciphers "AES128+EECDH:AES128+EDH";
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-Content-Type-Options nosniff;

----------
Basic auth secured with TLS:

Apparently, put .htpasswd, nginx.key and nginx.crt into /downloads root.

----------
Example, 64-bit:

Insecure

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:49161 -v ~/test:/downloads diameter/rtorrent-rutorrent:64

Secure

    $ docker run -dt --name rtorrent-rutorrent -p 443:443 -p 49160:49160/udp -p 49161:49161 -v ~/test:/downloads diameter/rtorrent-rutorrent:64

Example, map both secure and insecure ports, 32-bit:

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 443:443 -p 49160:49160/udp -p 49161:49161 -v ~/test:/downloads diameter/rtorrent-rutorrent:32

----------
Access web-interface: enter http://your_host_address:8080 in a browser for insecure version and https://your_host_address for secure version

----------
Example, specify rtorrent gid and uid, and increase php5-fpm memory limit:

    $ docker run -dt --name rtorrent-rutorrent -p 8080:80 -p 49160:49160/udp -p 49161:49161 -v ~/test:/downloads -e USR_ID=11000 -e GRP_ID=22000 -e PHP_MEM=1024M diameter/rtorrent-rutorrent:64

----------
Upgrade from older container version, move rtorrent scratch files and rutorrent configs to the new locations:

| Old | New |
| --- | --- |
| /downloads/.session | /downloads/.rtorrent/session |
| /downloads/watch | /downloads/.rtorrent/watch |
| /downloads/config | /downloads/.rutorrent |

----------

  [1]: http://wiki.nginx.org/Faq#How_do_I_generate_an_htpasswd_file_without_having_Apache_tools_installed.3F "Nginx FAQ"

