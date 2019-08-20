# Supervisor的安装与使用

### 安装
```bash
# 安装Python的打包分发工具setuptools
yum -y install python-setuptools
# 安装supervisor
easy_install supervisor
# 创建配置文件
echo_supervisord_conf > /etc/supervisord.conf
# 查看supervisor版本
[root@10-9-50-240 ~]# supervisord -v
4.0.4

# 下载supervisor自启动服务脚本并输出到/usr/lib/systemd/system/目录下的supervisord.service文件中
wget -O /usr/lib/systemd/system/supervisord.service  https://github.com/Supervisor/initscripts/raw/master/centos-systemd-etcs
# 设置supervisor开机自启动
systemctl enable supervisord.service
```

### 配置

```bash
vim /etc/supervisord.conf
```
配置：
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
创建上面的文件：
```bash
touch /var/run/supervisor.sock
chmod 777 /var/run/supervisor.sock
touch /var/log/supervisord.log
chmod 777 /var/log
```
supervisor会加载/etc/supervisor/conf.d/下的所有.conf文件，因此在/etc/supervisor/下创建conf.d文件夹
```bash
mkdir -p /etc/supervisor/conf.d/
```

创建test-process.conf(以项目名称命名的)
```bash
vim /etc/supervisor/conf.d/test-process.conf
```
```bash
[program:test-process]                              ; 进程名称，在supervisorctl中通过这个值来对进程进行一系列的操作
process_name==%(program_name)s                      ; 当numprocs为1时，process_name=%(program_name)s；当numprocs>=2时，process_name=%(program_name)s_%(process_num)02d
command=/usr/bin/php /root/testcode/test.php        ; 执行的命令
autostart=true                                      ; 在supervisord启动的时候也自动启动
autorestart=true                                    ; 进程异常退出后自动重启
user=root                                           ; 以哪个用户启动
numprocs=1                                          ; 启动几个进程
redirect_stderr=true                                ; 把stderr重定向到stdout
stdout_logfile=/var/log/supervisor/test-process.log ; stdout日志文件，需要注意当指定目录不存在时无法正常启动，所以需要手动创建目录(supervisord会自动创建日志文件)
```

test.php内容：
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
# 启动supervisord服务
systemctl start supervisord
# 查看supervisord服务状态
systemctl status supervisord
```

使配置文件生效
```bash
supervisorctl reread
supervisorctl update
```

启动进程(其实不用手动启动也可以，因为前面test-process.conf中配置了在supervisord启动的时候也自动启动)
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
# 重启supervisord或者修改了/etc/supervisord.conf需要执行
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

### 如何卸载
```bash
# 停止所有进程
supervisorctl -c /etc/supervisord.conf stop all
# 停止supervisord
systemctl stop supervisord
# 卸载
easy_install -mxN supervisor
```