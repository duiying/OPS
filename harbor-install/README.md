# HARBOR的安装与配置

#### 官方地址
```
https://github.com/goharbor/harbor
```
  

#### 1. 安装docker 17.03.0-ce+ and docker-compose 1.18.0+  
[docker-ce-yum-install](../docker-ce-yum-install)

#### 2. 安装HARBOR
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
```shell
# 登录
admin phpdev-pass
```

#### 3. 使用
```
1. 创建 wyx 用户
2. 创建 test 项目
3. 为 test 项目添加 wyx 用户, 角色是项目管理员
```
![Harbor](https://raw.githubusercontent.com/duiying/img/master/Harbor.jpg)  

登录报错
```shell
[root@localhost harbor]# docker login harbor.phpdev.com
Username: wyx
Password: 
Error response from daemon: Get https://harbor.phpdev.com/v2/: dial tcp 192.168.246.128:443: connect: connection refused
```
这是由于默认docker registry使用的是https, 而目前的Harbor使用的是http, 解决方法如下
```shell
# 查找 docker.service 所在目录
[root@localhost harbor]# find / -name docker.service -type f
/usr/lib/systemd/system/docker.service
# 增加 --insecure-registry harbor.phpdev.com:9010
[root@localhost harbor]# vim /usr/lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd --insecure-registry harbor.phpdev.com:9010 -H fd:// --containerd=/run/containerd/containerd.sock
# 重新加载配置、重启docker
systemctl daemon-reload
systemctl restart docker
```



