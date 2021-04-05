# 源码编译安装 Nginx、PHP8 以及 PHP 常见扩展

### 要求

在 work 账户下配置一套可运行的 Web 环境，详细如下：  

- Nginx 请下载并编译配置最新版本，HTTP 使用 8000 端口
- PHP 使用 8.x 最新版，配置 FPM 使用 9000 端口；
- PHP 请编译上如下模块或扩展：
  - curl
  - gd（需支持 JPEG、PNG、FreeType）
  - mbstring
  - mysqli
  - openssl
  - pcntl
  - sockets
  - xml
  - swoole（请编译最新版本，要求支持协程和 https）
  - redis
  - msgpack
  - rdkafka
  - uuid
  - apcu
  
### 准备

目前准备了一台纯净的 CentOS7.5 的机器，首先安装一些基础的软件环境：  

```sh
yum -y install net-tools
yum -y install vim
yum -y install wget
yum -y install autoconf
yum -y install gcc gcc-c++ make
yum -y install git
yum install -y zlib zlib-devel
yum -y install libxml2 libxml2-devel
yum -y install openssl openssl-devel
yum -y install sqlite-devel
yum -y install libcurl libcurl-devel
yum -y install gd
yum -y install libpng libpng-devel
yum -y install libjpeg libjpeg-devel libjpeg-turbo libjpeg-turbo-devel
yum -y install freetype freetype-devel
yum -y install oniguruma oniguruma-devel
```

新建一个 work 账户：  

```sh
useradd work
# 设置 work 账户密码为：w*1#erqt
passwd work
# 切换到 work 账号
su - work
```

准备一个 lib 目录，存放下载的软件包，再准备一个 php-extensions 目录，作为一些软件的安装目录：  

```sh
[work@VM-0-9-centos ~]$ mkdir lib
[work@VM-0-9-centos ~]$ mkdir php-extensions
[work@VM-0-9-centos ~]$ ls
lib  php-extensions
```

### 安装 PHP8 及基本扩展

```sh
[work@VM-0-9-centos ~]$ cd /home/work/lib/
[work@VM-0-9-centos lib]$ wget https://www.php.net/distributions/php-8.0.3.tar.gz && tar -xvf php-8.0.3.tar.gz php-8.0.3/ && cd php-8.0.3/
[work@VM-0-9-centos php-8.0.3]$ ./configure --prefix=/home/work/service/php80 --with-config-file-path=/home/work/service/php80/etc --with-config-file-scan-dir=/home/work/service/php80/etc/ext --with-fpm-user=work --with-fpm-group=work --disable-debug --disable-ipv6 --disable-rpath --enable-bcmath --enable-exif --enable-mysqlnd --enable-ftp --enable-mbregex --enable-pcntl --enable-xml --enable-mbstring --enable-sockets --enable-dom --enable-shmop --enable-sysvsem --enable-soap --enable-fpm --enable-tokenizer --with-mhash --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-pear --with-curl --with-openssl --with-zlib --enable-gd --with-jpeg --with-freetype
[work@VM-0-9-centos php-8.0.3]$ make && make install
```

`php.ini` 配置：  

```sh
# 先查看一下 ini 文件应该放到哪个目录下
[work@VM-0-9-centos etc]$ /home/work/service/php80/bin/php -r "phpinfo();" | grep 'php.ini'
Configuration File (php.ini) Path => /home/work/service/php80/etc
# 拷贝一份 ini 配置文件
[work@VM-0-9-centos etc]$ cp /home/work/lib/php-8.0.3/php.ini-production /home/work/service/php80/etc/php.ini
# 此时可以看到 ini 配置文件已经生效
[work@VM-0-9-centos etc]$ /home/work/service/php80/bin/php --ini
Configuration File (php.ini) Path: /home/work/service/php80/etc
Loaded Configuration File:         /home/work/service/php80/etc/php.ini
Scan for additional .ini files in: /home/work/service/php80/etc/ext
Additional .ini files parsed:      (none)
```

`php-fpm` 配置：  

```sh
[work@VM-0-9-centos php80]$ cp /home/work/service/php80/etc/php-fpm.conf.default /home/work/service/php80/etc/php-fpm.conf
[work@VM-0-9-centos php-fpm.d]$ cp /home/work/service/php80/etc/php-fpm.d/www.conf.default /home/work/service/php80/etc/php-fpm.d/www.conf
```

如何启动 `php-fpm`？  

```sh
[work@VM-0-9-centos php-fpm.d]$ /home/work/service/php80/sbin/php-fpm
[05-Apr-2021 20:07:18] NOTICE: [pool www] 'user' directive is ignored when FPM is not running as root
[05-Apr-2021 20:07:18] NOTICE: [pool www] 'group' directive is ignored when FPM is not running as root
[work@VM-0-9-centos php-fpm.d]$ ps -ef | grep fpm
work     28100     1  0 20:07 ?        00:00:00 php-fpm: master process (/home/work/service/php80/etc/php-fpm.conf)
work     28101 28100  0 20:07 ?        00:00:00 php-fpm: pool www
work     28102 28100  0 20:07 ?        00:00:00 php-fpm: pool www
```

### 安装 Nginx

```sh
[work@VM-0-9-centos ~]# cd /home/work/lib/
[work@VM-0-9-centos lib]# wget http://nginx.org/download/nginx-1.19.9.tar.gz && tar -xvf nginx-1.19.9.tar.gz && cd nginx-1.19.9/
[work@VM-0-9-centos nginx-1.19.9]# ./configure --prefix=/home/work/service/nginx \
--user=work \
--group=work \
--with-pcre \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-http_slice_module \
--with-mail \
--with-threads \
--with-file-aio \
--with-stream \
--with-mail_ssl_module \
--with-stream_ssl_module
[work@VM-0-9-centos nginx-1.19.9]# make && make install
# 查看一下 Nginx 版本号
[work@VM-0-9-centos nginx-1.19.9]# /home/work/service/nginx/sbin/nginx -v
nginx version: nginx/1.19.9
```

Nginx 配置如下：  

`vim /home/work/service/nginx/conf/nginx.conf`：  

```
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;

    keepalive_timeout  65;

    server {
        listen       8001;
        server_name  localhost;

        location / {
            root   html;
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
    include vhosts/*.conf;
}
```

新建目录：`mkdir /home/work/service/nginx/conf/vhosts`，新建配置文件：`vim /home/work/service/nginx/conf/vhosts/test.conf`，配置文件内容如下：  

```
server {
    listen       8000;
    server_name  localhost;

    root /home/work/www;
    index index.html index.htm index.php;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        try_files $uri =404;
    }
}
```

启动 Nginx：`/home/work/service/nginx/sbin/nginx -c /home/work/service/nginx/conf/nginx.conf`。  

新建 www 目录，并创建 `index.php`：  

```sh
[work@VM-0-9-centos nginx-1.19.9]$ mkdir /home/work/www
[work@VM-0-9-centos nginx-1.19.9]$ cd /home/work/www/
[work@VM-0-9-centos www]$ vim /home/work/www/index.php
```

`index.php` 内容如下：  

```php
<?php
phpinfo();
```

此时，可以访问：`IP:8000`，可以看到 phpinfo 的内容了。  






