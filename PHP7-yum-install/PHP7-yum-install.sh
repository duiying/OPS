#!/bin/bash

# 安装epel源(epel是基于Fedora的一个项目，为"红帽系"的操作系统提供额外的软件包)
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# 安装webtatic源(安装webtatic-release之前需要先安装epel-release)
rpm -ivh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# 安装PHP及其扩展
yum -y install  mod_php72w \
                php72w-bcmath \
                php72w-cli \
                php72w-common \
                php72w-devel \
                php72w-fpm \
                php72w-gd \
                php72w-mbstring \
                php72w-mysql \
                php72w-opcache \
                php72w-pdo \
                php72w-xml

# 安装Composer并配置阿里云源
curl -sSL https://getcomposer.org/installer | php &&\
    mv composer.phar /usr/local/bin/composer &&\
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

echo "===================================================="
php -v
composer -V
echo "===================================================="