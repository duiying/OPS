# 安装docker-ce

### 脚本描述
```
使用yum安装安装docker-ce最新版和docker-compose
```

### 官方文档
- [https://docs.docker.com/install/linux/docker-ce/centos/](https://docs.docker.com/install/linux/docker-ce/centos/)
- [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

### 脚本内容
[docker-ce-yum-install.sh](docker-ce-yum-install.sh)
```shell
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
wget https://github.com/docker/compose/releases/download/1.24.1/docker-compose-Linux-x86_64
mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose

# 赋予可执行权限
chmod +x /usr/local/bin/docker-compose

echo "===================================================="
docker -v
docker-compose --version
echo "===================================================="
```

### 执行
```shell
bash docker-ce-yum-install.sh
```