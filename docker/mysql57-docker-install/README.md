# 通过 Docker 安装 MySQL

### 脚本描述
```
通过 Docker 安装 MySQL5.7 并启动
```

### 脚本内容

[mysql57-docker-install.sh](mysql57-docker-install.sh)  

```shell
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
-v ${CONFDIR}/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
--name mysql \
mysql:5.7
```

### 执行

```shell
bash mysql57-docker-install.sh
```