# Supervisor 的安装与使用

## 目录
- [介绍](#介绍)
- [安装](#安装)
- [配置](#配置)
- [常见命令](#常见命令)
- [如何卸载](#如何卸载)
- [Supervisor 如何定期重启指定进程](#Supervisor如何定期重启指定进程)

### 介绍

Supervisor 是用 Python 开发的一个客户机/服务器系统，允许用户监视和控制 UNIX 类操作系统上的多个进程。  
功能包括监听、启动、停止、重启一个或多个进程。当 Supervisor 管理的进程出现意外被 Kill 后，Supervisor 监听到事件会自动启动该进程，不需要再写其他脚本去进行重启处理。  
关于 Supervisor 的安装及设定，可以参考 Supervisor 官网地址：http://supervisord.org/   

### 安装

```bash
# 安装 Python 的打包分发工具 setuptools
yum -y install python-setuptools
# 安装 supervisor
easy_install supervisor
# 创建配置文件
echo_supervisord_conf > /etc/supervisord.conf
# 查看 supervisor 版本
$ supervisord -v
4.0.4

# 下载 supervisor 自启动服务脚本并输出到 /usr/lib/systemd/system/ 目录下的 supervisord.service 文件中
wget -O /usr/lib/systemd/system/supervisord.service  https://github.com/Supervisor/initscripts/raw/master/centos-systemd-etcs
# 设置 supervisor 开机自启动
systemctl enable supervisord.service
```

### 配置

```bash
vim /etc/supervisord.conf
```

修改下面配置：  

```bash
...
[unix_http_server]
file=/var/run/supervisor.sock   ; the path to the socket file
...
[supervisord]
logfile=/var/log/supervisord.log ; main log file; default $CWD/supervisord.log
...
pidfile=/var/run/supervisord.pid ; supervisord pidfile; default supervisord.pid
...
[supervisorctl]
serverurl=unix:///var/run/supervisor.sock ; use a unix:// URL  for a unix socket
...
[include]
files = /etc/supervisor/conf.d/*.conf
```

然后创建上面的文件：  

```bash
touch /var/run/supervisor.sock
chmod 777 /var/run/supervisor.sock
touch /var/log/supervisord.log
chmod 777 /var/log
```
supervisor 会加载 /etc/supervisor/conf.d/ 下的所有 .conf 文件，因此在 /etc/supervisor/ 下创建 conf.d 文件夹  

```bash
mkdir -p /etc/supervisor/conf.d/
```

创建 test-process.conf（以项目名称命名的）  

```bash
vim /etc/supervisor/conf.d/test-process.conf
```
```bash
[program:test-process]                              ; 进程名称，在 supervisorctl 中通过这个值来对进程进行一系列的操作
process_name==%(program_name)s                      ; 当 numprocs 为 1 时，process_name=%(program_name)s；当 numprocs>=2 时，process_name=%(program_name)s_%(process_num)02d
command=/usr/bin/php /root/testcode/test.php        ; 执行的命令
autostart=true                                      ; 在 supervisord 启动的时候也自动启动
autorestart=true                                    ; 进程异常退出后自动重启
user=root                                           ; 以哪个用户启动
numprocs=1                                          ; 启动几个进程
redirect_stderr=true                                ; 把 stderr 重定向到 stdout
stdout_logfile=/var/log/supervisor/test-process.log ; stdout 日志文件，需要注意当指定目录不存在时无法正常启动，所以需要手动创建目录（supervisord 会自动创建日志文件）
```

test.php 内容：  

```php
<?php
    date_default_timezone_set('Asia/Shanghai');
    while (true) {
        $content = date('Y-m-d H:i:s', time()) . PHP_EOL;
        file_put_contents('/root/testcode/1.log', $content, FILE_APPEND);
        sleep(3);
    }
```

创建日志目录  

```bash
mkdir -p /var/log/supervisor/
```

启动  

```bash
# 启动 supervisord 服务
systemctl start supervisord
# 查看 supervisord 服务状态
systemctl status supervisord
```

使配置文件生效  

```bash
supervisorctl reread
supervisorctl update
```

启动进程（其实不用手动启动也可以，因为前面 `test-process.conf` 中配置了在 supervisord 启动的时候也自动启动）
```bash
# -c参数指定配置文件路径，如果没有-c参数默认是/etc/supervisord.conf
supervisorctl -c /etc/supervisord.conf start test-process:*
```

停止进程  

```bash
supervisorctl -c /etc/supervisord.conf stop test-process:*
```

### 常见命令

```bash
# 重启 supervisord 或者修改了 /etc/supervisord.conf 需要执行
supervisorctl reload

# 启动进程
supervisorctl -c /etc/supervisord.conf start program_name

# 停止进程
supervisorctl -c /etc/supervisord.conf stop program_name

# 重启进程
supervisorctl -c /etc/supervisord.conf restart program_name

# 启动所有进程
supervisorctl -c /etc/supervisord.conf start all

# 停止所有进程
supervisorctl -c /etc/supervisord.conf stop all
```
### Supervisor如何定期重启指定进程

每小时重启指定进程  

```bash
0 * * * * supervisorctl -c /etc/supervisord.conf restart program_name
```

当对于某些会出现内存泄漏或连接不自动释放的进程时，我们可以使用以上方法进行定期重启，解决内存泄漏及释放连接数。

### 如何卸载
```bash
# 停止所有进程
supervisorctl -c /etc/supervisord.conf stop all
# 停止 supervisord
systemctl stop supervisord
# 卸载
easy_install -mxN supervisor
```