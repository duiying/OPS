#!/bin/bash

docker ps | grep mysql
if [ $? -eq 0 ]; then
docker rm -f mysql
fi

DATADIR=`pwd`/data
CONFDIR=`pwd`/conf

docker run -d -p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=root \
-v ${DATADIR}:/var/lib/mysql \
-v ${CONFDIR}:/etc/mysql \
--name mysql \
mysql:5.7