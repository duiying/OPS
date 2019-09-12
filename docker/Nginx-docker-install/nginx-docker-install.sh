#!/bin/bash

WWWDIR=`pwd`/www
CONFDIR=`pwd`/conf.d
LOGDIR=`pwd`/log

docker run \
--name nginx \
-d -p 80:80 443:443 \
-v ${WWWDIR}:/usr/share/nginx/html \
-v ${LOGDIR}:/var/log/nginx \
-v ${CONFDIR}:/etc/nginx/conf.d \
nginx