# Composer 安装

参考地址：https://pkg.phpcomposer.com/#how-to-install-composer  

```bash
# 下载安装脚本 － composer-setup.php － 到当前目录。
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"

# 执行安装过程。
php composer-setup.php

# 删除安装脚本。
php -r "unlink('composer-setup.php');"
```

全局安装：将 Composer 安装到系统环境变量 PATH 所包含的路径下面，然后就能够在命令行窗口中直接执行 composer 命令了。  

```bash
sudo mv composer.phar /usr/local/bin/composer
```

测试

```bash
$ composer --version
Composer version 1.10.6 2020-05-06 10:28:10
```

阿里云镜像配置  

```bash
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
```
