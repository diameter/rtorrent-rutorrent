#!/bin/bash

set -x

MEM=${PHP_MEM:=256M}

sed -i 's/memory_limit.*$/memory_limit = '$MEM'/g' /etc/php5/fpm/php.ini

php5-fpm --nodaemonize

