# Nginx安装ssl证书
1、以腾讯云为例，去SSL证书管理控制台：https://console.cloud.tencent.com/ssl 下载并解压缩证书文件包到本地目录。  

2.、解压缩后，可获得相关类型的证书文件。其中包含Nginx文件夹和CSR文件。
```
文件夹名称：Nginx
文件夹内容：
    1_www.domain.com_bundle.crt 证书文件
    2_www.domain.com.key 私钥文件
CSR 文件内容： www.domain.com.csr 文件
```
说明：CSR 文件是申请证书时由您上传或系统在线生成的，提供给 CA 机构。安装时可忽略该文件。
    
3、将已获取到的 1_www.domain.com_bundle.crt 证书文件和 2_www.domain.com.key 私钥文件从本地拷贝到服务器的某个目录下。  
4、Nginx配置：
```
server {
    listen 443;

    server_name phpedu.club www.phpedu.club;
    root /usr/share/nginx/html;
    index index.html index.htm index.php;

    # 启用 SSL 功能
    ssl on;
    # 证书文件名称
    ssl_certificate /etc/nginx/conf.d/ssl/1_phpedu.club_bundle.crt;
    # 私钥文件名称
    ssl_certificate_key /etc/nginx/conf.d/ssl/2_phpedu.club.key;
    ssl_session_timeout 5m;
    # 请按照这个协议配置
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    # 请按照这个套件配置，配置加密套件，写法遵循 openssl 标准。
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;

    location ~* /\. {
        deny all;
    }
}

server {
    listen 80;
    server_name phpedu.club www.phpedu.club;
    # 把http的域名请求转成https
    rewrite ^(.*)$ https://$host$1 permanent;
}
```
5、重启Nginx。


### 参考
- [https://cloud.tencent.com/document/product/400/35244](https://cloud.tencent.com/document/product/400/35244)