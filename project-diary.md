###　day-1

#### 成果

学习`Dockerfile`和`docker-compose`，并基于它们实现了三个容器的创建，最终完成集群的基本配置。

集群中的每个容器有以下特征：

- 实现了用户`kfk`的创建，并给予其管理员权限（`sudo`免密码）
- 固定`ip`并做了`ip`和`hostname`的映射
- 安装好了`java8`并配置好环境变量
- 其余一些必要的配置

#### 难点

优雅地去书写`Dockerfile`和`docker-compose.yml`，使镜像和容器尽可能的小。

优雅地构建镜像并批量生成容器。

#### 疑惑

还有一个问题没解决，就是端口的动态映射，这个到安装`hadoop`和`yarn`时必须要处理。

资料标明可以用`iptables`来解决，希望到时候可以顺利解决。

#### 部分效果展示

![集群状态](http://pic.xcq5120.xyz/hadoopNews-day1-1.png)

![节点状态](http://pic.xcq5120.xyz/hadoopNews-day1-2.png)



