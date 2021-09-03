<h1 align="center"> OPS </h1>
<p align="center">
软件安装、环境部署、一键脚本等
</p>

- CentOS7

  - [CentOS7 初始化](common-software-install)
  - [源码编译安装 Nginx、PHP8 以及 PHP 常见扩展](nginx-php-source-install)
  - [通过 yum 安装 Nginx](nginx-yum-install)
  - [通过 yum 安装 MySQL5.7](mysql57-yum-install)
  - [安装 docker、docker-compose](docker-yum-install)
  - [安装 docker-ce](docker-ce-yum-install)
  - [删除所有容器和镜像](docker-rm-all)
  - [关闭并开机禁用 firewalld](firewalld-disable)
  - [通过 yum 安装 gitlab-ce-11.9.11](gitlab-ce-11.9.11-yum-install)
  - [Harbor 的安装与配置](harbor-install)
  - [通过源码安装 redis5.0.5](redis5-src-install)
  - [Jenkins 的安装与配置](Jenkins-yum-install)
  - [Jenkins 的简单使用](Jenkins-Gogs)
  - [通过 yum 安装 PHP7](PHP7-yum-install)
  - [Supervisor 的安装与使用](Supervisor)
  - [PostgreSQL 的安装](PostgreSQL)
  - [Sentry 的安装](Sentry)
  - [CentOS7 搭建 samba 实现与 Win 共享目录](samba)
  - [Go 安装](go-install)

- Docker

  - [通过 Docker 安装 MySQL5.7](docker/mysql57-docker-install)
  - [Gogs 的搭建](docker/Gogs-docker-install)
  - [Nginx 的搭建](docker/Nginx-docker-install)
  - [RabbitMQ 的搭建](docker/RabbitMQ-docker-install)
  - [MySQL 主从复制](https://github.com/duiying/dockerfiles/tree/master/mysql-master-slave)
  - [搭建 Redis-Cluster 三主三从以及集群的扩容缩容](https://github.com/duiying/dockerfiles/tree/master/redis-cluster)
  - [搭建 Kafka 集群](https://github.com/duiying/dockerfiles/tree/master/kafka-cluster)

- 常用脚本

  - [定时清理日志脚本](Docs/定时清理日志脚本.md)
  - [SSH 免密码登录](Script/auto-password-ssh-login)
  - [如何使用 PHP 脚本来增量订阅错误日志？](Docs/如何使用PHP脚本来增量订阅错误日志？.md)
  - [如何使用 PHP 脚本来保证其他进程的 KeepAlive？](Docs/如何使用PHP脚本来保证其他进程的KeepAlive？.md)
  - [如何保证同一时刻只有一个 PHP 脚本在运行？](Docs/如何保证同一时刻只有一个PHP脚本在运行？.md)

- Nginx

    - [Nginx 安装 ssl 证书](Nginx/ssl-install)
