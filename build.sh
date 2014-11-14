#!/bin/bash
set -e
set -x
docker build -t "local/rutorrent:1" ./rutorrent
docker build -t "local/rtorrent:1" ./rtorrent

