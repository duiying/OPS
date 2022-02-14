# 如何通过 RDB 文件分析大 Key？

### 前言

目前 Redis 内存占用过大，如何分析出大 Key？  

### 工具介绍

关于 Redis RDB 文件解析的工具，目前了解到的主要有下面两款：  

1. Python 写的 [redis-rdb-tools](https://github.com/sripathikrishnan/redis-rdb-tools) 工具
2. Go 写的 [rdr](https://github.com/xueqiu/rdr) 工具  

`redis-rdb-tools` 号称比 `redis-rdb-tools` 速度更快，这里我找了一张对比图：  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/RDB工具对比.png" width="400"></div>  

### rdr 如何使用？

官方文档：https://github.com/xueqiu/rdr 。  

在本地 Mac 下载 rdr 工具：https://github.com/xueqiu/rdr/releases/download/v0.0.1/rdr-darwin 。然后：  

```sh
chmod +x rdr-darwin
mv rdr-darwin rdr
```

**1、show 格式**：可视化网页。  

```sh
./rdr show -p 8080 dump.rdb
```

浏览器访问 http://127.0.0.1:8080 ，效果如下：  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/测试RedisRDB.png" width="1000"></div>  

拿线上的 RDB 文件分析一下，效果如下：  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/线上RedisRDB.png" width="1000"></div>  

**2、dump 格式测试**：json 信息。  

```sh
./rdr dump dump.rdb
```

json 信息中包含了：类型、Key 名字、大小、包含多少 Key。

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/RDBdump_0.png" width="400"></div>

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/RDBdump_1.png" width="400"></div>  

**3、keys 格式测试**：所有 Key。  

```sh
./rdr keys dump.rdb
```

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/RDBdump_3.png" width="400"></div>  










