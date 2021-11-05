# PHP-FPM 配置

第一次执行，提示没有 /private/etc/php-fpm.conf 这个文件  

```bash
$ php-fpm
[19-May-2020 10:32:36] ERROR: failed to open configuration file '/private/etc/php-fpm.conf': No such file or directory (2)
[19-May-2020 10:32:36] ERROR: failed to load configuration file '/private/etc/php-fpm.conf'
[19-May-2020 10:32:36] ERROR: FPM initialization failed
```

新建 /private/etc/php-fpm.conf 文件  

```bash
sudo cp /private/etc/php-fpm.conf.default /private/etc/php-fpm.conf
```

第二次执行，提示打开日志文件失败  

```bash
$ php-fpm
[19-May-2020 10:38:45] WARNING: Nothing matches the include pattern '/private/etc/php-fpm.d/*.conf' from /private/etc/php-fpm.conf at line 143.
[19-May-2020 10:38:45] ERROR: failed to open error_log (/usr/var/log/php-fpm.log): No such file or directory (2)
[19-May-2020 10:38:45] ERROR: failed to post process the configuration
[19-May-2020 10:38:45] ERROR: FPM initialization failed
```

编辑 /private/etc/php-fpm.conf 文件，新建 /usr/local/var/log/php-fpm.log  

```ini
; Default Value: log/php-fpm.log
;error_log = log/php-fpm.log
error_log = /usr/local/var/log/php-fpm.log
```

第三次执行，提示没有 /private/etc/php-fpm.d/*.conf
```bash
$ php-fpm
[19-May-2020 10:44:49] WARNING: Nothing matches the include pattern '/private/etc/php-fpm.d/*.conf' from /private/etc/php-fpm.conf at line 144.
[19-May-2020 10:44:49] ERROR: No pool defined. at least one pool section must be specified in config file
[19-May-2020 10:44:49] ERROR: failed to post process the configuration
[19-May-2020 10:44:49] ERROR: FPM initialization failed
```

新建 www.conf
```bash
sudo cp /private/etc/php-fpm.d/www.conf.default /private/etc/php-fpm.d/www.conf
```

第四次执行提示需要 root  

```bash
$ php-fpm
[19-May-2020 10:47:46] NOTICE: [pool www] 'user' directive is ignored when FPM is not running as root
[19-May-2020 10:47:46] NOTICE: [pool www] 'group' directive is ignored when FPM is not running as root
```

用 sudo 执行，提示 9000 端口被占用  

```bash
$ sudo php-fpm
[19-May-2020 10:48:01] ERROR: unable to bind listening socket for address '127.0.0.1:9000': Address already in use (48)
[19-May-2020 10:48:01] ERROR: FPM initialization failed
```

更改端口  

```bash
$ sudo vim /private/etc/php-fpm.d/www.conf
listen = 127.0.0.1:9999
```

PID 配置  

```bash
$ vim /etc/php-fpm.conf
pid = /usr/local/var/run/php-fpm.pid
mkdir -p /usr/local/var/run/
```

php.ini 文件配置  

```bash
sudo cp /private/etc/php.ini.default /private/etc/php.ini
```

启动服务  

```bash
sudo php-fpm -D
```

**如何重启 FPM？**  

```bash
sudo killall php-fpm
sudo php-fpm 或者 /usr/sbin/php-fpm -R
```
