# Rsyslog 相关

Rsyslog 使用场景：将数据同步到 Kafka，供 Consumer 进行消费。（各技术组之间的数据通信、分布式日志收集）

### Rsyslog 相关配置

- 关闭 selinux，重启系统：`vim /etc/selinux/config`，将 SELINUX 值更改为 disabled
- 拷贝 Rsyslog 配置文件到指定目录：`cp Kafka-Skeleton/rsyslog/* /etc/rsyslog.d/`
- 安装 rsyslog-kafka：`yum -y install rsyslog-kafka`
- 每次改完 Rsyslog，需要重启 Rsyslog：`systemctl restart rsyslog`

### 注意事项

Rsyslog 监听目录下所有文件文件的变化，当目录下文件过多的时候 Rsyslog 将为每一个文件监听一个进程，且不会短暂释放资源，会导致 Rsyslog 收集任务失败，报错：`Too many open files`。  

解决方案：建议加定时脚本清理日志文件，见：[定时清理日志脚本](定时清理日志脚本.md)。  
