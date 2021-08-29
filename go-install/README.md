# Go 安装

```sh
# 下载 & 解压
wget https://studygolang.com/dl/golang/go1.17.linux-amd64.tar.gz
tar -xvf go1.17.linux-amd64.tar.gz -C /home/work/service

# vim /etc/profile
export GOROOT=/home/work/service/go
export GOPATH=/home/work/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
source /etc/profile

# 创建目录
mkdir -p /home/work/gopath
```
