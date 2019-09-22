# PostgreSQL的安装与使用

### 安装
官方安装文档：https://www.postgresql.org/download/linux/redhat/
```bash
# 安装存储库RPM
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# 安装客户端
yum -y install postgresql96

# 安装服务端
yum -y install postgresql96-server

# 安装其它模块
yum -y install postgresql96-contrib

# 初始化数据库
/usr/pgsql-9.6/bin/postgresql96-setup initdb
# 开机自启动
systemctl enable postgresql-9.6
# 启动服务
systemctl start postgresql-9.6
```

### 使用
参考文档：http://www.ruanyifeng.com/blog/2013/12/getting_started_with_postgresql.html
```bash
# 切换到postgres用户(PostgreSQL会创建一个默认的Linux用户postgres)
[root@10-9-50-240 /]# su - postgres
# 使用psql命令登录PostgreSQL控制台，系统提示符会变成postgres=#，表示进入了数据库控制台
# 相当于系统用户postgres以数据库同名用户的身份，登录数据库，这是不用输入密码的
-bash-4.2$ psql
psql (9.6.15)
Type "help" for help.
# PostgreSQL数据库创建一个postgres用户作为数据库的管理员，用下面的命令来修改密码
postgres=# ALTER USER postgres WITH PASSWORD '123456@postgress';
# 创建sentry数据库
postgres=# create database sentry;
CREATE DATABASE
postgres=#
# 退出控制台
postgres-# \q
```
