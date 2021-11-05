# Redis5 安装

进入到指定目录  

```bash
cd /usr/local
```

去 Redis 官网（ https://redis.io/download ）下载安装包  

```bash
sudo wget http://download.redis.io/releases/redis-5.0.8.tar.gz
```

解压  

```bash
sudo tar -xvf redis-5.0.8.tar.gz
```

删除压缩包  

```bash
sudo rm -rf redis-5.0.8.tar.gz
```

进入 Redis 目录  

```bash
cd redis-5.0.8
```

编译、安装  

```bash
sudo make
sudo make install
```

修改配置文件
```bash
sudo vim /usr/local/redis-5.0.8/redis.conf
# 改为守护模式
daemonize yes
```

启动 Redis 服务  

```bash
redis-server /usr/local/redis-5.0.8/redis.conf
```

客户端连接  
```bash
redis-cli
```
