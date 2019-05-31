# CentOS7初始化

### 脚本描述
```
纯净的CentOS7系统, 需要安装一些常用的软件, 如git、vim等.
```

### 脚本内容
[common-software-install.sh](common-software-install.sh)
```shell
#!/bin/bash

# '\033[字背景颜色;字体颜色m字符串\033[0m' 
GREENCOLOR='\033[1;32m'
NC='\033[0m'

echo "===================================================="
printf "${GREENCOLOR} install begin ${NC} \n"
echo "===================================================="

# 为了使用ifconfig命令, 需要安装net-tools
yum -y install net-tools
yum -y install vim
yum -y install wget
yum -y install gcc gcc-c++ make
yum -y install git

echo "===================================================="
printf "${GREENCOLOR} install finish ${NC} \n"
echo "===================================================="
```

### 执行
```shell
bash common-software-install.sh
```
