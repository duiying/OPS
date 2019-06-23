# 通过源码安装redis5.0.5

### 脚本描述
```
通过源码安装redis5.0.5并启动服务
```

### 脚本内容
[redis5-src-install.sh](redis5-src-install.sh)
```shell
#!/bin/bash

DOWNLOAD_DIR="/usr/src"
SOURCE_DIR="http://download.redis.io/releases/redis-5.0.5.tar.gz"

# 安装依赖
yum -y install  libxml2 libxml2-devel  telnet pcre-devel curl-devel

# 进入下载目录
cd $DOWNLOAD_DIR
# 下载源码包
wget $SOURCE_DIR

# 解压
tar -xzvf redis-5.0.5.tar.gz
# 进入目录
cd redis-5.0.5
# 编译
make
# 安装
make install

# 启动redis服务端
cd src
./redis-server
```

### 客户端连接
```shell
redis-cli -h 127.0.0.1 -p 6379
```

### 让redis服务在后台启动
```shell
# 进入目录
cd /usr/src/redis-5.0.5/
# 拷贝出一份自定义配置文件
cp redis.conf myredis.conf
# 修改配置文件 daemonize no => daemonize yes port 6379 => port 6397
vim myredis.conf
# 以指定配置文件启动redis服务
cd /usr/src/redis-5.0.5/src
./redis-server /usr/src/redis-5.0.5/myredis.conf
# 查看redis服务是否启动
[root@localhost src]# ps -ef | grep redis
root       6431      1  0 15:59 ?        00:00:00 ./redis-server 127.0.0.1:6397
root       6438   6361  0 16:00 pts/1    00:00:00 grep --color=auto redis
# 客户端连接
redis-cli -h 127.0.0.1 -p 6397
```

### 执行
```shell
bash redis5-src-install.sh
```