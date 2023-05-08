# 通过 Docker 安装 Redis

### 脚本描述
```
通过 Docker 安装 Redis5.0.8 并启动
```

### 脚本内容

```shell
# 拉取镜像
docker pull redis:5.0.8

# 修改配置文件
# 1、下载官方配置文件：https://github.com/redis/redis/blob/5.0.8/redis.conf
# 2、进行下面 3 处修改
# 2.1 appendonly no => appendonly yes
# 2.2、bind 127.0.0.1 去掉前面注释
# 2.3、# requirepass foobared => requirepass 654321

# 启动
docker run --name test-redis \
-v /本地目录/conf/redis.conf:/etc/redis.conf \
-v /本地目录/data:/data \
-p 6380:6379 \
-d redis:5.0.8 redis-server /etc/redis.conf
```