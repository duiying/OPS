#!/bin/bash

# '\033[字背景颜色;字体颜色m字符串\033[0m'
GREENCOLOR='\033[1;32m'
NC='\033[0m'

DOWNLOAD_DIR="/usr/src"
SOURCE_DIR="https://mirror.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-11.9.11-ce.0.el7.x86_64.rpm"

# GitLab 的主机和端口
HOST="gitlab.phpdev.com"
PORT="8088"

echo "===================================================="
printf "${GREENCOLOR} GitLab's install begin ${NC} \n"
echo "===================================================="

# 安装常用软件
yum -y install net-tools vim wget autoconf gcc gcc-c++ make git

# 关闭防火墙
systemctl stop firewalld
# 开机禁用防火墙
systemctl disable firewalld

# 安装 postfix 邮件服务依赖
yum -y install postfix
# 启动 postfix 并设置为开机启用
systemctl start postfix && systemctl enable postfix

# 安装其它依赖
yum -y install curl policycoreutils policycoreutils-python openssh-server openssh-clients

# 进入目录
cd $DOWNLOAD_DIR
# 下载 GitLab 包
wget $SOURCE_DIR
# 安装 GitLab 的 yum 源
rpm -ivh gitlab-ce-11.9.11-ce.0.el7.x86_64.rpm
# 安装 GitLab
yum -y install gitlab-ce

# 备份配置文件
cp /etc/gitlab/gitlab.rb{,.bak}
# 修改配置文件 external_url 'http://gitlab.example.com' => external_url 'http://gitlab.phpdev.com:8088'
sed -i "s/external_url 'http:\/\/gitlab.example.com'/external_url 'http:\/\/${HOST}:${PORT}'/" /etc/gitlab/gitlab.rb
# 使配置生效
gitlab-ctl reconfigure

# 启动 GitLab
gitlab-ctl start

echo "===================================================="
printf "${GREENCOLOR} GitLab's install finish ${NC} \n"
echo "===================================================="