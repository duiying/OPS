# Kafka 安装

1、安装。  

```sh
brew install kafka
```

安装会依赖 ZK，安装目录：`/usr/local/Cellar/kafka/2.2.0/`。  

2、配置文件目录。  

`/usr/local/etc/kafka/server.properties`  

`/usr/local/etc/kafka/zookeeper.properties`  

3、使用。  

```sh
kafka-console-producer --broker-list IP:HOST --topic test-topic-name
```
