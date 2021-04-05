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