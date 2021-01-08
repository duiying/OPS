#!/bin/bash

# '\033[字背景颜色;字体颜色m字符串\033[0m'
GREENCOLOR='\033[1;32m'
NC='\033[0m'

echo "===================================================="
printf "${GREENCOLOR} Docker's install begin ${NC} \n"
echo "===================================================="

# 安装 EPEL
yum -y install epel-release
# 安装 docker 和 docker-compose
yum -y install docker docker-compose
# 配置阿里云 docker 镜像加速器
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://8auvmfwy.mirror.aliyuncs.com"]
}
EOF
# 重新加载配置、重启 docker
systemctl daemon-reload
systemctl restart docker

echo "===================================================="
printf "${GREENCOLOR} Docker's install finish ${NC} \n"
docker_version=$(docker -v)
printf "${GREENCOLOR} ${docker_version} ${NC} \n"
echo "===================================================="