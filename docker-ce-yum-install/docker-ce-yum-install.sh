#!/bin/bash

# 卸载旧版本
yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-engine

# 安装所需软件包
yum install -y  yum-utils \
                device-mapper-persistent-data \
                lvm2

# 设置存储库
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 安装最新版的docker-ce
yum -y install docker-ce docker-ce-cli containerd.io

# 配置阿里云docker镜像加速器
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://8auvmfwy.mirror.aliyuncs.com"]
}
EOF

# 重新加载配置、重启docker
systemctl daemon-reload
systemctl restart docker

# 安装docker-compose
# 下载docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 赋予可执行权限
chmod +x /usr/local/bin/docker-compose

echo "===================================================="
docker -v
docker-compose --version
echo "===================================================="