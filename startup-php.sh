#!/bin/bash

set -x

MEM=${PHP_MEM:=256M}

sed -i 's/memory_limit.*$/memory_limit = '$MEM'/g' /etc/php/7.0/fpm/php.ini

php-fpm7.0 --nodaemonize

