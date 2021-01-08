# Jenkins 的安装与配置

Jenkins：Java 开发的持续集成工具

### 安装与配置

安装

```shell
# 安装 JDK（需要 1.8 及以上）
yum install -y java
# 查看 JDK 版本
$ java -version
openjdk version "1.8.0_191"
OpenJDK Runtime Environment (build 1.8.0_191-b12)
OpenJDK 64-Bit Server VM (build 25.191-b12, mixed mode)
# 安装 Jenkins
$ wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
$ rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
$ yum install -y jenkins

# 创建 Jenkins 服务用户
useradd deploy

# 备份配置文件
cp /etc/sysconfig/jenkins{,.bak}

# 更改 Jenkins 启动用户并查看端口
vim /etc/sysconfig/jenkins
    # 29 行左右 JENKINS_USER="jenkins" 改为 JENKINS_USER="deploy"
    # 56 行左右查看 Jenkins 端口 JENKINS_PORT="8080"
    
# 更改目录权限
chown -R deploy:deploy /var/lib/jenkins
chown -R deploy:deploy /var/log/jenkins

# 启动 Jenkins
systemctl start jenkins

# 查看 8080 端口，发现没有被占用，说明 Jenkins 启动失败
lsof -i:8080
# 查看 Jenkins 日志
[root@localhost ~]# cat /var/log/jenkins/jenkins.log
java.io.FileNotFoundException: /var/cache/jenkins/war/META-INF/MANIFEST.MF (Permission denied)
# 给 deploy 赋予目录权限
chown -R deploy:deploy /var/cache/jenkins/

# 重启 Jenkins
systemctl restart jenkins
[root@localhost ~]# lsof -i:8080
COMMAND  PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2177 deploy  162u  IPv6  27305      0t0  TCP *:webcache (LISTEN)

# 至此，Jenkins 安装并启动成功。
```

配置 hosts

```shell
sudo vi /etc/hosts 
# 192.168.246.128 jenkins.example.com
```

浏览器访问：http://jenkins.example.com:8080

### 使用

初始化界面   

![jenkins-init](https://raw.githubusercontent.com/duiying/img/master/jenkins-init.png)  

开始界面  

![jenkins-start](https://raw.githubusercontent.com/duiying/img/master/jenkins-start.png)  

正在安装插件界面  

![jenkins-starting](https://raw.githubusercontent.com/duiying/img/master/jenkins-starting.png)  

创建第一个 admin 用户界面  

![jenkins-admin](https://raw.githubusercontent.com/duiying/img/master/jenkins-admin.png)  

URL 配置界面  

![jenkins-url](https://raw.githubusercontent.com/duiying/img/master/jenkins-url.png)  

ready 界面  
  
![jenkins-ready](https://raw.githubusercontent.com/duiying/img/master/jenkins-ready.png)  

首页界面   

![jenkins-index](https://raw.githubusercontent.com/duiying/img/master/jenkins-index.png)  


