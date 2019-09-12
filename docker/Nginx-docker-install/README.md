# Nginx的搭建

### 脚本描述
```
通过Docker搭建Nginx
```

### 脚本内容
[nginx-docker-install.sh](nginx-docker-install.sh)
```shell
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
```

### 执行
```shell
bash nginx-docker-install.sh
```