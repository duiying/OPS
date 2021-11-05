# MySQL 安装

安装  

```bash
brew install mysql
```

安装完成  

```bash
==> Summary
🍺  /usr/local/Cellar/mysql/8.0.19_1: 286 files, 288.8MB
==> Caveats
==> mysql
We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
    mysql -uroot

To have launchd start mysql now and restart at login:
  brew services start mysql
Or, if you don't want/need a background service you can just run:
  mysql.server start
```

启动服务  

```bash
brew services start mysql
```

重置 root 密码为 12345678  

```bash
mysql_secure_installation
```

客户端连接服务  

```bash
mysql -uroot -p
```

my.cnf 位置  

```
/usr/local/etc/my.cnf
```
