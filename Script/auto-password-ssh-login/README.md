# SSH免密码登录

### 脚本内容

```shell
#!/usr/bin/expect

set server [lindex $argv 0];
set timeout 3

spawn ssh root@your ip
expect "passphrase"
send "your password\r"
interact
```
