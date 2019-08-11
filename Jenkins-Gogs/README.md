# Jenkins的简单使用
```
Jenkins的简单使用，持续集成Gogs。
```

配置任务名称、描述、环境参数。  
![Jenkins-create](https://raw.githubusercontent.com/duiying/img/master/Jenkins-create.jpg)  
配置部署类型  
![Jenkins-deploy](https://raw.githubusercontent.com/duiying/img/master/Jenkins-deploy.jpg)  
配置Git仓库地址  
![Jenkins-Git](https://raw.githubusercontent.com/duiying/img/master/Jenkins-Git.jpg)  
定义Shell
![Jenkins-Shell](https://raw.githubusercontent.com/duiying/img/master/Jenkins-Shell.jpg)  
```bash
#!/bin/sh

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

cd /root/Docker-LNMP/www/Laravel-Demo-Jenkins

echo "[INFO] env type is $env_type"
echo "[INFO] deploy type is $deploy_type"

if [[ "$deploy_type" == "composer_update" ]]; then
    echo "[INFO] composer update ..."
    composer update
elif [[ "$deploy_type" == "code_update" ]]; then
    echo "[INFO] code update ..."
fi
```
控制台输出
```bash
Started by user admin
Running as SYSTEM
Building in workspace /root/Docker-LNMP/www/Laravel-Demo-Jenkins
No credentials specified
 > git rev-parse --is-inside-work-tree # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url http://gogs.phpedu.club:10080/gogsadmin/Laravel-Demo-Jenkins.git # timeout=10
Fetching upstream changes from http://gogs.phpedu.club:10080/gogsadmin/Laravel-Demo-Jenkins.git
 > git --version # timeout=10
 > git fetch --tags --progress http://gogs.phpedu.club:10080/gogsadmin/Laravel-Demo-Jenkins.git +refs/heads/*:refs/remotes/origin/*
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10
Checking out Revision 01ee63222aebdad5fcb8f4db95b0fa50c6ca3ae4 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 01ee63222aebdad5fcb8f4db95b0fa50c6ca3ae4
Commit message: "first commit"
 > git rev-list --no-walk 01ee63222aebdad5fcb8f4db95b0fa50c6ca3ae4 # timeout=10
[Laravel-Demo-Jenkins] $ /bin/sh /tmp/jenkins1458883304361909617.sh
[INFO] env type is dev
[INFO] deploy type is code_update
[INFO] code update ...
Finished: SUCCESS
```





