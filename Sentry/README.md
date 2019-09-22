# Sentry的安装

## 目录
- [简介](#简介)
- [依赖](#依赖)
- [安装](#安装)
  - [Redis相关安装](#Redis相关安装)
  - [PostgreSQL相关安装](#PostgreSQL相关安装)
  - [Python相关安装](#Python相关安装)
  - [其它依赖软件相关安装](#其它依赖软件相关安装)
  - [Sentry安装相关](#Sentry安装相关)
  - [配置文件相关](#配置文件相关)
  - [运行迁移相关](#运行迁移相关)
  - [启动服务](#启动服务)
- [总结](#总结)

### 简介
Sentry 是一个开源的实时错误报告工具，支持 web 前后端、移动应用以及游戏，支持 Python、OC、Java、Go、Node、Django、RoR 等主流编程语言和框架 ，还提供了 GitHub、Slack、Trello 等常见开发工具的集成。

### 依赖
官方文档：https://docs.sentry.io/server/installation/python/  

运行Sentry所需的一些基本先决条件：
```
基于 UNIX 的操作系统
PostgreSQL：版本 9.5 以上
Redis
Python 2.7
Pip 8.1+
python-setuptools, python-dev, libxslt1-dev, gcc, libffi-dev, libjpeg-dev, libxml2-dev, libxslt-dev, libyaml-dev, libpq-dev
```

### 安装

#### Redis相关安装
安装Redis：[通过源码安装redis5.0.5](../redis5-src-install)  

#### PostgreSQL相关安装
安装PostgreSQL：[PostgreSQL的安装与使用](../PostgreSQL)  

#### Python相关安装
由于系统自带Python2.7，所以就不需要手动安装Python了。
```bash
[root@10-9-50-240 /]# python --version
Python 2.7.5
```
但是pip(Python包管理工具)，是需要手动进行安装的。
```bash
[root@10-9-50-240 /]# pip --version
-bash: pip: command not found
```
安装pip
```bash
[root@10-9-50-240 /]# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
[root@10-9-50-240 /]# python get-pip.py --default-timeout=1000
[root@10-9-50-240 /]# pip --version
pip 19.2.3 from /usr/lib/python2.7/site-packages/pip (python 2.7)
```

#### 其它依赖软件相关安装
```bash
yum -y install  python-setuptools \
                python-dev \
                libxslt1-dev \
                gcc \
                gcc-c++ \
                libffi-dev \
                libjpeg-dev \
                libxml2-dev \
                libxslt-dev \
                libyaml-dev \
                libpq-dev
```

#### Sentry安装相关
每个应用可能需要拥有自己独立的Python环境，virtualenv就是用来为一个应用创建一套隔离的Python运行环境。
```bash
# 安装virtualenv
pip install -U virtualenv
# 使用virtualenv命令创建Python虚拟环境
virtualenv /www/sentry/
# 使用虚拟环境的时候，必须"激活"它
source /www/sentry/bin/activate
# 安装Sentry
pip install -U sentry
# 如何关闭虚拟环境
deactivate
```
可能报错：
```
ERROR: Failed building wheel for uwsgi
```
解决：
```bash
yum -y install python-devel
```

#### 配置文件相关
初始化配置，指定配置路径为/etc/sentry。
```bash
sentry init /etc/sentry
```
/etc/sentry目录下创建了sentry.conf.py和config.yml两个配置文件。  

配置数据库：
```bash
# vim /etc/sentry/sentry.conf.py
DATABASES = {
    'default': {
        'ENGINE': 'sentry.db.postgres',
        'NAME': 'sentry',
        'USER': 'sentry',
        'PASSWORD': '123456@sentry',
        'HOST': '127.0.0.1',
        'PORT': '5432',
        'AUTOCOMMIT': True,
        'ATOMIC_REQUESTS': False,
    }
}
```
配置邮箱：
```bash
# vim /etc/sentry/config.yml
mail.backend: 'smtp'  # Use dummy if you want to disable email entirely
mail.host: 'smtp.163.com'
mail.port: 25
mail.username: 'xxx'
mail.password: 'xxx'
mail.use-tls: false
# The email address to send on behalf of
mail.from: 'xxx'
```
配置Redis：
```bash
# vim /etc/sentry/config.yml
redis.clusters:
  default:
    hosts:
      0:
        host: 127.0.0.1
        port: 6379
```
需要在PostgreSQL中创建sentry用户、赋予sentry用户sentry数据库的所有权限、将sentry用户角色修改为superuser。
```bash
postgres=# CREATE USER sentry WITH PASSWORD '123456@sentry';
postgres=# GRANT ALL PRIVILEGES ON DATABASE sentry to sentry;
postgres=# alter role sentry superuser;
```

#### 运行迁移相关
使用upgrade命令创建初始架构：
```bash
SENTRY_CONF=/etc/sentry sentry upgrade
```
报错：
```bash
django.db.utils.OperationalError: FATAL:  Ident authentication failed for user "postgres"
```
这是由于PostgreSQL的认证导致，解决：
```bash
# vim /var/lib/pgsql/9.6/data/pg_hba.conf

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
# IPv6 local connections:
host    all             all             ::1/128                 ident

ident是Linux下PostgreSQL默认的local认证方式，改为md5认证方式：

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
```
重启PostgreSQL：
```bash
[root@10-9-156-155 sentry]# systemctl restart postgresql-9.6
```
重新执行上次的命令：
```bash
# 需要先激活虚拟环境
[root@10-9-156-155 sentry]# source /www/sentry/bin/activate
# 重新执行
(sentry) [root@10-9-156-155 sentry]# SENTRY_CONF=/etc/sentry sentry upgrade
```

报错：
```bash
django.db.utils.OperationalError: OperationalError('could not open extension control file "/usr/pgsql-9.6/share/extension/citext.control": No such file or directory\n',)
SQL: CREATE EXTENSION IF NOT EXISTS citext
```
解决，参考：https://github.com/getsentry/sentry/issues/6229
```bash
# 这里用的是下面的解决方式
yum -y install postgresql96-contrib
```
创建第一个用户，该用户将充当超​​级用户：
```bash
(sentry) [root@10-9-156-155 sentry]# SENTRY_CONF=/etc/sentry sentry createuser
报错：
IndexError: list index out of range
```
解决，参考：https://github.com/getsentry/sentry/issues/7015
```bash
# vim /etc/sentry/sentry.conf.py
# True改为False
SENTRY_SINGLE_ORGANIZATION = False
```
重新创建用户：
```bash
(sentry) [root@10-9-156-155 sentry]# SENTRY_CONF=/etc/sentry sentry createuser
04:40:05 [WARNING] sentry.utils.geo: settings.GEOIP_PATH_MMDB not configured.
Email: 1822581649@qq.com
Password:
Repeat for confirmation:
Should this user be a superuser? [y/N]: y
User created: 1822581649@qq.com
```

#### 启动服务
启动WEB服务：
```bash
SENTRY_CONF=/etc/sentry sentry run web
```
启动worker：
```bash
SENTRY_CONF=/etc/sentry sentry run worker
```
访问：http://ip:9000
### 总结
安装过程多去参考官方文档：https://docs.sentry.io/server/installation/python/  
 
搭建Sentry尽量使用内存大于1g的机器  

virtualenv要了解  

PostgreSQL要了解  

遇到问题多谷歌，看GitHub的issue  






