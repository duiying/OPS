# RabbitMQ的搭建

拉取镜像
```bash
# management版本带web管理界面
docker pull rabbitmq:3.7.3-management
```

启动容器
```bash
# 5672是应用访问端口，15672是WEB访问端口。
# 登录用户名admin，密码123456
docker run -d --name rabbitmq --hostname my-rabbitmq -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=123456 rabbitmq:3.7.3-management
```

访问：http://127.0.0.1:15672/ 。