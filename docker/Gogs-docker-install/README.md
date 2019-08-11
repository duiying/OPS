# Gogs的搭建

Gogs：一款极易搭建的自助Git服务。  
官网：https://gogs.io/  
基于docker的安装文档：https://github.com/gogs/gogs/tree/master/docker  

### 安装
```shell
# Pull image from Docker Hub.
docker pull gogs/gogs

# Create local directory for volume.
mkdir -p /var/gogs

# Use `docker run` for the first time.
docker run -di --name=gogs -p 10022:22 -p 10080:3000 -v /var/gogs:/data gogs/gogs

# Use `docker start` if you have stopped it.
docker start gogs
```
此时，访问：http://yourIP:10080/ 即可，接下来是Gogs的安装向导。  

### 配置数据库  
![Gogs-db](https://raw.githubusercontent.com/duiying/img/master/Gogs-db.jpg)  
因此，需要有个DB服务，我这里用的是MySQL。  
```sql
create database gogs DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

### 基本设置
![Gogs-base](https://raw.githubusercontent.com/duiying/img/master/Gogs-base.jpg)  
由于宿主机的/var/gogs目录与容器的/data目录之间的映射关系，因此目录的设置如下
- 仓库根目录：/data/git/gogs-repositories
- 应用URL：http://gogs.phpedu.club:10080/
- 日志路径：/data/gogs/log

### 可选设置
![Gogs-choose](https://raw.githubusercontent.com/duiying/img/master/Gogs-choose.jpg)   
