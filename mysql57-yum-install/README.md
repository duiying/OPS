# 安装Mysql

### 脚本描述
```
使用yum安装MySQL5.7并启动
```

### 脚本内容
[mysql57-yum-install.sh](mysql57-yum-install.sh)
```shell
#!/bin/bash

# '\033[字背景颜色;字体颜色m字符串\033[0m'
GREENCOLOR='\033[1;32m'
NC='\033[0m'

DOWNLOAD_DIR="/usr/src"
SOURCE_DIR="http://repo.mysql.com/mysql57-community-release-el7-8.noarch.rpm"

echo "===================================================="
printf "${GREENCOLOR} MySQL's install begin ${NC} \n"
echo "===================================================="

# 安装MySQL
# 如果安装过MySQL, 先卸载
yum -y remove mysql
# 进入目录
cd $DOWNLOAD_DIR
# 下载MySQL包
wget $SOURCE_DIR
# 安装MySQL的yum源
rpm -ivh mysql57-community-release-el7-8.noarch.rpm
# 安装MySQL
yum -y install mysql-community-server
# 启动MySQL
service mysqld start

echo "===================================================="
printf "${GREENCOLOR} MySQL's install finish ${NC} \n"
cat /var/log/mysqld.log | grep 'temporary password'
echo "===================================================="
```

### 执行
```shell
bash mysql57-yum-install.sh
```