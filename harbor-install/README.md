# HARBOR的安装与配置

官方地址
```
https://github.com/goharbor/harbor
```
  

1. 安装docker 17.03.0-ce+ and docker-compose 1.18.0+  
[docker-ce-yum-install](../docker-ce-yum-install)

2. 安装HARBOR
安装文档
```
https://github.com/goharbor/harbor/blob/master/docs/installation_guide.md
```
下载
```shell
# 进入下载目录
cd /usr/src/

# 下载离线安装包
wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-offline-installer-v1.8.0.tgz

# 解压安装包
tar xvf harbor-offline-installer-v1.8.0.tgz

# 进入HARBOR目录
cd harbor
```
配置HARBOR
```shell
vim harbor.yml

# 配置如下
hostname: harbor.phpdev.com
port: 9010
harbor_admin_password: phpdev-pass
# The location to store harbor's data
data_volume: /usr/src/harbor/data
# The directory to store store log
location: /var/log/harbor
```
安装
```shell
./install.sh
```
配置hosts, 浏览器访问 http://harbor.phpdev.com:9010
