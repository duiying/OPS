# Swoole 扩展安装

新建目录  

```bash
$ mkdir -p /usr/local/lib/php
$ cd /usr/local/lib/php
```

安装 Swoole  

```bash
wget https://github.com/swoole/swoole-src/archive/v4.5.1.zip
unzip v4.5.1.zip
cd /usr/local/lib/php/swoole-src-4.5.1
```

查看 phpize 命令位置  

```bash
whereis phpize
```

执行 phpize  

```bash
$ phpize
grep: /usr/include/php/main/php.h: No such file or directory
grep: /usr/include/php/Zend/zend_modules.h: No such file or directory
grep: /usr/include/php/Zend/zend_extensions.h: No such file or directory
Configuring for:
PHP Api Version:        
Zend Module Api No:     
Zend Extension Api No:  
Cannot find autoconf. Please check your autoconf installation and the
$PHP_AUTOCONF environment variable. Then, rerun this script.
```

安装 autoconf  

```bash
brew install autoconf automake
```

重新执行 phpize  

```bash
grep: /usr/include/php/main/php.h: No such file or directory
grep: /usr/include/php/Zend/zend_modules.h: No such file or directory
grep: /usr/include/php/Zend/zend_extensions.h: No such file or directory
```

发现找不到头文件  

```bash
# 重启 按 ⌘ + R 菜单栏 > 实用工具 > 终端
csrutil disable
# 重启完成后
# 重新挂载，重要!!! 否则 sudo 也无法修改 /usr 目录
sudo mount -uw /
# 软链
sudo ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr/include/ /usr/include
```

重新执行 phpize，发现 OK 了。  

```bash
./configure
make
sudo make install
```

执行结果  

```bash
Libraries have been installed in:
   /usr/local/lib/php/swoole-src-4.5.1/modules
...
----------------------------------------------------------------------
Installing shared extensions:     /usr/lib/php/extensions/no-debug-non-zts-20180731/
Installing header files:          /usr/include/php/
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
extension=swoole.so
```

最后，查看 Swoole 扩展  

```bash
$ php --ri swoole

swoole

Swoole => enabled
Author => Swoole Team <team@swoole.com>
Version => 4.5.1
Built => May 19 2020 23:23:10
coroutine => enabled
kqueue => enabled
rwlock => enabled
pcre => enabled
zlib => 1.2.11
async_redis => enabled

Directive => Local Value => Master Value
swoole.enable_coroutine => On => On
swoole.enable_library => On => On
swoole.enable_preemptive_scheduler => Off => Off
swoole.display_errors => On => On
swoole.use_shortname => On => On
swoole.unixsock_buffer_size => 262144 => 262144
```

如何关闭 Swoole 短名？  

```bash
$ sudo vim /etc/php.ini
# 最后一行加入
swoole.use_shortname='Off'
# 查看 Swoole 扩展信息
$ php --ri swoole
swoole

Swoole => enabled
Author => Swoole Team <team@swoole.com>
Version => 4.5.1
Built => May 19 2020 23:23:10
coroutine => enabled
kqueue => enabled
rwlock => enabled
pcre => enabled
zlib => 1.2.11
async_redis => enabled

Directive => Local Value => Master Value
swoole.enable_coroutine => On => On
swoole.enable_library => On => On
swoole.enable_preemptive_scheduler => Off => Off
swoole.display_errors => On => On
swoole.use_shortname => Off => Off
swoole.unixsock_buffer_size => 262144 => 262144
```
