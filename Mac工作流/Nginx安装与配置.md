# Nginx 安装与配置

安装 Nginx  

```bash
brew install nginx
```

安装完成的提示信息  

```bash
==> nginx
Docroot is: /usr/local/var/www

The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that
nginx can run without sudo.

nginx will load all files in /usr/local/etc/nginx/servers/.

To have launchd start nginx now and restart at login:
  brew services start nginx
Or, if you don't want/need a background service you can just run:
  nginx
```

启动、停止  

```bash
brew services start nginx
brew services restart nginx
brew services stop nginx
```

下面介绍 Nginx 配置站点的流程。  

vim /usr/local/etc/nginx/nginx.conf  

```bash
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /usr/local/var/log/nginx/access.log  main;

    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       8080;
        server_name  localhost;

        location / {
            root   html;
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }

    include /usr/local/etc/nginx/conf.d/*.conf;
}
```

/usr/local/etc/nginx/conf.d/hyperf.conf  

```bash
upstream hyperf {
    # 至少需要一个 Hyperf 节点，多个配置多行
    server 127.0.0.1:9501;
}

server {
    listen 80;
    server_name hyperf.com;

    location / {
        # 将客户端的 Host 和 IP 信息一并转发到对应节点
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # 执行代理访问真实服务器
        proxy_pass http://hyperf;
    }
}
```
