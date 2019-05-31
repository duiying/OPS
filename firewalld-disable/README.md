# 关闭并开机禁用firewalld

### 脚本描述
```
关闭并开机禁用firewalld
```

### 脚本内容
[firewalld-disable.sh](firewalld-disable.sh)
```shell
#!/bin/bash

# '\033[字背景颜色;字体颜色m字符串\033[0m'
GREENCOLOR='\033[1;32m'
NC='\033[0m'

echo "===================================================="
printf "${GREENCOLOR} firewalld's disable begin ${NC} \n"
echo "===================================================="

# 关闭防火墙
systemctl stop firewalld
# 开机禁用防火墙
systemctl disable firewalld

echo "===================================================="
printf "${GREENCOLOR} firewalld's disable finish ${NC} \n"
echo "===================================================="
```

### 执行
```shell
bash firewalld-disable.sh
```