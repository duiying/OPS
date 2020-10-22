# CentOS7 搭建 samba 实现与Win共享目录

**搭建**  

```shell
# 1、关闭防火墙、selinux

# 2. 安装samba
yum -y install samba

# 3、修改 samba 配置文件（首先备份配置文件）
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
vim /etc/samba/smb.conf
# 底部新增内容
[www]
comment = www           # 说明
path = /data/www        # 资源路径
valid users = smbuser   # 能够访问资源的用户
browseable = yes        # 是yes/否no在浏览资源中显示共享目录
writable = yes          # 是yes/否no不以只读方式共享
create mask = 0777      # 建立文件时所给的权限
directory mask = 0777   # 建立目录时所给的权限

# 4、添加用户
useradd smbuser
passwd smbuser
# samba添加用户
smbpasswd -a smbuser

# 5、添加共享文件夹
mkdir -p /data/www
chmod -R 777 /data/www
chown -R smbuser:smbuser /data

# 6、重启 samba 服务
systemctl restart smb
```

**如何在 Win 中打开**  

1、文件夹中打开  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/samba.png" width="400"></div>  

2、运行中打开  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/samba-2.png" width="400"></div>  

3、映射网络驱动器  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/映射网络驱动器.png" width="400"></div>  

此时会多出一个盘符  

<div align=center><img src="https://raw.githubusercontent.com/duiying/img/master/盘符.png" width="400"></div>  

**注意**  

Win 在登录 samba 时，会缓存用户名和密码，当想切换 samba 用户登录时需要清除缓存  

```
# net use 打印缓存连接列表
# net use 远程连接名称 /del 删除一个连接
# net use * /del 删除全部连接

C:\Users\wyx>net use
会记录新的网络连接。


状态       本地        远程                      网络

-------------------------------------------------------------------------------
已断开连接             \\192.168.246.128\IPC$    Microsoft Windows Network
命令成功完成。

C:\Users\wyx>net use \\192.168.246.128\IPC$ /del
\\192.168.246.128\IPC$ 已经删除。

C:\Users\wyx>net use * /del
列表是空的。
```

**参考**  

- [https://blog.csdn.net/yt_php/article/details/80787331](https://blog.csdn.net/yt_php/article/details/80787331)
- [https://www.cnblogs.com/thammer/p/8283704.html](https://www.cnblogs.com/thammer/p/8283704.html)

