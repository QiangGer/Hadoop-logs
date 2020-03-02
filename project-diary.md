### day-1

#### 成果

学习`Dockerfile`和`docker-compose`，并基于它们实现了三个容器的创建，最终完成集群的基本配置。

集群中的每个容器有以下特征：

- 实现了用户`kfk`的创建，并给予其管理员权限（`sudo`免密码）
- 固定ip并做了ip和`hostname`的映射
- 安装好了`Java8`并配置好环境变量
- 其余一些必要的配置

#### 难点

优雅地去书写`Dockerfile`和`docker-compose.yml`，使镜像和容器尽可能的小。

优雅地构建镜像并批量生成容器。

#### 疑惑

还有一个问题没解决，就是端口的动态映射，这个到安装`Hadoop`和`Yarn`时必须要处理。

资料标明可以用`iptables`来解决，希望到时候可以顺利解决。

#### 部分效果展示

**容器概览：**
![集群状态](http://pic.xcq5120.xyz/hadoopNews-day1-1.png)

**节点的主机名，集群的联通性，Java安装检验**
![节点状态](http://pic.xcq5120.xyz/hadoopNews-day1-2.png)



### day-2

#### 成果

首先解决了昨天的问题，方法是直接在实体机配置容器ip和域名的映射，从而在浏览器通过域名访问。

主要成果是在昨日的基础上完成了`Hadoop`和`Yarn`的集群搭建。并将软件以数据卷的方式存储，可以重复使用。

另外配置了`ssh`免密连接，通过主节点一键管理从节点的服务。

最后还修改了`Dockerfile`，让其更加使用优雅（数据卷的使用）。

#### 难点

ssh免密连接后，环境变量失效的问题。经过多方查证，理解原因后，通过修改`/etc/profile`来解决，并写入`Dockerfile`。

#### 疑惑

难点的解决不够优雅，会导致每次`docker exec`进行不必要的操作，虽然对使用没影响，但总能做的更好，留给日后优化。

ssh免密配置的部分不知能否在`Dockerfile`中解决，从而简化二次使用。

各个节点的软件和配置文件都一样，不知能否使用同一数据卷存储，有待考证。

#### 部分效果展示

**MapReduce的正确性检验：**
![mr job](http://pic.xcq5120.xyz/hadoopNews-day2-1.png)

**Yarn的管理页通过浏览器访问是kfk用户在管理**
![集群状态](http://pic.xcq5120.xyz/hadoopNews-day2-2.png)

**可以通过浏览器管理MR任务的日志**
![集群状态](http://pic.xcq5120.xyz/hadoopNews-day2-3.png)

**配置ssh免密后集群的管理**
![集群状态](http://pic.xcq5120.xyz/hadoopNews-day2-4.png)