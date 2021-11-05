# Redis 扩展安装

**请先安装 Swoole 扩展**  

进入目录  

```bash
cd /usr/local/lib/php
```

下载源码  

```bash
git clone https://github.com/phpredis/phpredis.git
```

进入源码目录  

```bash
cd /usr/local/lib/php/phpredis
```

执行 phpize  

```bash
phpize
```

配置  

```bash
./configure
```

编译  

```bash
make
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib/php/phpredis/modules

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `DYLD_LIBRARY_PATH' environment variable
     during execution

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
```

安装  

```bash
sudo make install
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib/php/phpredis/modules

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `DYLD_LIBRARY_PATH' environment variable
     during execution

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
Installing shared extensions:     /usr/lib/php/extensions/no-debug-non-zts-20180731/
```

修改 php.ini  

```bash
# 查看 php.ini 位置
php --ini
Configuration File (php.ini) Path: /etc
Loaded Configuration File:         /etc/php.ini
Scan for additional .ini files in: (none)
Additional .ini files parsed:      (none)

sudo vim /etc/php.ini
# 最后一行加入
extension=redis.so
```

最后，查看 Redis 扩展  

```bash
$ php --ri redis

redis

Redis Support => enabled
Redis Version => 5.2.0
Redis Sentinel Version => 0.1
Git revision => $Id: e80600e244b8442cb7c86e99b067966cd59bf2ee $
Available serializers => php, json

Directive => Local Value => Master Value
redis.arrays.algorithm => no value => no value
redis.arrays.auth => no value => no value
redis.arrays.autorehash => 0 => 0
redis.arrays.connecttimeout => 0 => 0
redis.arrays.distributor => no value => no value
redis.arrays.functions => no value => no value
redis.arrays.hosts => no value => no value
redis.arrays.index => 0 => 0
redis.arrays.lazyconnect => 0 => 0
redis.arrays.names => no value => no value
redis.arrays.pconnect => 0 => 0
redis.arrays.previous => no value => no value
redis.arrays.readtimeout => 0 => 0
redis.arrays.retryinterval => 0 => 0
redis.arrays.consistent => 0 => 0
redis.clusters.cache_slots => 0 => 0
redis.clusters.auth => no value => no value
redis.clusters.persistent => 0 => 0
redis.clusters.read_timeout => 0 => 0
redis.clusters.seeds => no value => no value
redis.clusters.timeout => 0 => 0
redis.pconnect.pooling_enabled => 1 => 1
redis.pconnect.connection_limit => 0 => 0
redis.session.locking_enabled => 0 => 0
redis.session.lock_expire => 0 => 0
redis.session.lock_retries => 10 => 10
redis.session.lock_wait_time => 2000 => 2000
```
