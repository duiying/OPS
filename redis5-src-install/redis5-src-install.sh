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
