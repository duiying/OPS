#!/bin/bash

# '\033[字背景颜色;字体颜色m字符串\033[0m'
GREENCOLOR='\033[1;32m'
NC='\033[0m'

echo "===================================================="
printf "${GREENCOLOR} Nginx's install begin ${NC} \n"
echo "===================================================="

# 安装Nginx
# 进入目录
cd /usr/src
# 下载Nginx包
wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
# 安装Nginx的yum源
rpm -ivh nginx-release-centos-7-0.el7.ngx.noarch.rpm
# 安装Nginx
yum -y install nginx
# 启动Nginx
service nginx restart

echo "===================================================="
printf "${GREENCOLOR} Nginx's install finish ${NC} \n"
echo "===================================================="