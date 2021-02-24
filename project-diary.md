 ## day-1

 ### 成果
学习 `Dockerfile` 和 `docker-compose`，并基于它们实现了三个容器的创建，最终完成集群的基本配置。

集群中的每个容器有以下特征：
- 实现了用户 kfk 的创建，并给予其管理员权限（ `sudo` 免密码）。
- 固定 ip 并做了 ip 和 hostname 的映射。
- 安装好了 Java 并配置好环境变量。
- 其余一些必要的配置。

### 难点

优雅地去书写 `Dockerfile` 和 `docker-compose.yml` ，使镜像和容器尽可能的小。

优雅地构建镜像并批量生成容器。

 ### 疑惑

还有一个问题没解决，就是端口的动态映射，这个到安装 Hadoop 和 Yarn 时必须要处理。

资料标明可以用 `iptables` 来解决，希望到时候可以顺利解决。

 ###  部分效果展示

**容器概览：**
![集群状态](http://pic.xuecq.cc/hadoopNews-day1-1.png)
**节点的主机名，集群的联通性，Java安装检验：**
![节点状态](http://pic.xuecq.cc/hadoopNews-day1-2.png)







 ## day-2

 ### 成果

首先解决了昨天的问题，方法是直接在实体机配置容器 ip 和域名的映射，从而在浏览器通过域名访问。

主要成果是在昨日的基础上完成了 Hadoop 和 Yarn 的集群搭建，并将软件以数据卷的方式存储，可以重复使用。

另外配置了 ssh 免密连接，通过主节点一键管理从节点的服务。

最后还修改了 `Dockerfile` ，让其更加使用优雅（数据卷的使用）。

 ### 难点

ssh 免密连接后，环境变量失效的问题。经过多方查证，理解原因后，通过修改 `/etc/profile` 来解决，并写入`Dockerfile` 。

 ### 疑惑

难点的解决不够优雅，会导致每次 `docker exec` 进行不必要的操作，虽然对使用没影响，但总能做的更好，留给日后优化。

ssh 免密配置的部分不知能否在 `Dockerfile` 中解决，从而简化二次使用。

各个节点的软件和配置文件都一样，不知能否使用同一数据卷存储，有待考证。

 ### 部分效果展示

**MapReduce 的正确性检验：**
![mr job](http://pic.xuecq.cc/hadoopNews-day2-1.png)

**Yarn 的管理页通过浏览器访问是用户 kfk 在管理**：
![Yarn管理](http://pic.xuecq.cc/hadoopNews-day2-2.png)

**可以通过浏览器管理 MR 任务的日志**：
![日志聚合](http://pic.xuecq.cc/hadoopNews-day2-3.png)

**配置 ssh 免密后集群的管理**：
![ssh免密连接](http://pic.xuecq.cc/hadoopNews-day2-4.png)





 ## day-3
 ### 成果

书写`rebuild.sh` 和 `autoSsh.sh`，并修改了自带的 `start（stop）-all.sh` ，简化了管理流程。

解决了例如环境变量不存在和主机名错误等几个 bug。

下载安装配置测试 ZooKeeper 集群。

 ### 难点

bug 定位和 Shell 脚本的编写。

 ### 疑惑

Shell 的四种模式还有疑惑，需要去学习。

 ### 部分效果展示

**启动 ZooKeeper**：
![ZooKeeper](http://pic.xuecq.cc/hadoopNews-day3-1.png)





 ## day4 和 day-5

 ### 成果

学习配置并测试 HDFS HA 以及 Yarn HA 。

修复了一些 bug 。

 ### 难点

HA 的正确配置以及集群的正确启动顺序。

active 不能正确切换的 debug 。

 ### 疑惑

暂无。

 ### 部分效果展示
**HDFS HA 的测试**：
![HDFS HA](http://pic.xuecq.cc/hadoopNews-day4-1.png)

**Yarn HA 可通过浏览器和执行 MapReduce 任务检验，比较繁琐，就不截图了**





 ## day-6 和 day-7

 ### 成果

学习配置测试 HBase 。

学习配置测试 Kafka 。

完善集群管理脚本，方便操作。



 ### 难点

无

 ### 疑惑

几个无关紧要的 warning 很想去掉，折腾了半天都没解决。

 ### 部分效果展示
 **Hbase 的测试**：
![Hbase](http://pic.xuecq.cc/hadoopNews-day6-1.png)
 **Kafka 的测试**：
略







 ## day-8

 ### 成果

Flume 的安装和配置。

二次开发 Flume 以适配 Hbase 。

下载日志文件并进行预处理。

完善集群管理脚本，方便操作。



 ### 难点

日志文件的格式化。

 ### 疑惑

难以在 shell 上修改日志的编码，因为默认编码是未知的。最后是通过桌面程序修改的。




 ## day-9
 ### 成果

书写 Java 程序模拟日志输入。

完成数据采集的全部流程，要求 Kafka 消费端有数据， HBase 有数据。

 ### 难点

整合组件，完成需求。

 ### 疑惑

Hbase 会写入一个空行，暂时未知是何导致，可能是表头，待验证。




 ## day-10

 ### 成果

hive 模块的集成测试

 ### 难点

整合组件，测试 sql 语句

 ### 疑惑

无

 ### 部分效果展示

 **Hive 的测试**：
![Hbase](http://pic.xuecq.cc/hadoopNews-day10-1.png)
 **Hive 的测试**：
![Hbase](http://pic.xuecq.cc/hadoopNews-day10-2.png)



 ## day-11

 ### 成果

hue 模块的编译集成测试
整合组件们

 ### 难点

编译过程中各种问题的解决。

版本的兼容，试了好多次才成功。

 ### 疑惑

无

 ### 部分效果展示
 **Hue 的测试**：
![Hbase](http://pic.xuecq.cc/hadoopNews-day11-1.png)





## day-12

 ### 成果
安装 maven scale 等组件。

Spark 的编译和使用。

 ### 难点
修改编译脚本来加速。

版本的兼容。

 ### 疑惑
Spark 的基本数据结构需要花时间学习。

 ### 部分效果展示
 **Spark 的测试**：
![Spark](http://pic.xuecq.cc/hadoopNews-day12-2.png)
**Spark Web UI**：
![Spark2](http://pic.xuecq.cc/hadoopNews-day12-1.png)



## day-13

 ### 成果
 配置 Spark 开发环境，并创建IDEA Maven 工程。

 开发 Spark Application 程序并进行本地调试。

 打 Jar 包并提交 Spark-submit 运行。

 Spark Standalone 集群模式配置和测试。

 Spark on Yarn 集群模式配置和测试 。



 ### 难点
打 Jar 包时，主类默认为 Java 类，最后需修改成 Scala 对象。

Spark 项目的日志保存并查看。

Spark on Yarn 模式下，spark-shell 的 webUI 会被随机“Filter”到一个空闲的机器上，从而可能导致无法正常通过 Yarn 界面访问。这个问题是无解的（2020.4月），因为Yarn 的机制决定了这个问题。好在 Spark-shell 基本上不会在 Yarn 下用，一般都是 standalone 状态下用。



 ### 疑惑
除了 Yarn log 的方式，不知是否有办法直接通过 webUI 浏览已结束的 Spark 任务日志。

短时间大量 submit 任务会导致 NodeManager 内存不足而进入 unhealthy 状态，不知是否和修改了 Yarn vmem-check 和 pmem-check 有关。但若机器内存充足，此问题一定不会发送。



 ### 部分效果展示
 **Spark Standalone**：
![Spark-standalone](http://pic.xuecq.cc/hadoopNews-day13-1.png)
**Spark On Yarn**：
![Spark-on-yarn](http://pic.xuecq.cc/hadoopNews-day13-2.png)





## day-14

 ### 成果
学习 Spark 的三大弹性分布式数据集的概念，特性，依赖关系，运行过程和基本操作。

学习 Spark 的运行基本流程。

学习 Spark SQL 的服务架构和特点。

Spark SQL 与Hive集成（spark-shell)。

Spark SQL 与Hive集成（spark-sql)。

Spark SQL与 Mysql 集成。

Spark SQL与HBase集成。



 ### 难点
理解 Spark 运行流程中，stage 的划分与 RDD 的宽窄依赖。

集成组件时，jar 包版本的不适配的排错。



 ### 疑惑
Spark SQL 和 HBase 集成后，若运行例如  select count *  命令，则会报错，但又会给出正确结果，原因未知。



 ### 部分效果展示
 **Spark SQL 和 Hive 的集成**：
![Spark-standalone](http://pic.xuecq.cc/hadoopNews-day14-1.png)
**Spark SQL 和 HBase 的集成**：
![Spark-on-yarn](http://pic.xuecq.cc/hadoopNews-day14-2.png)



## day-15

 ### 成果
升级 Kafka 版本，用于集成 Structured Streaming。

Structured Streaming 集成 Mysql。

基于结构化流完成业务数据实时分析。



 ### 难点
Kafka 升级后，原先的 topic 失效了，导致服务无法正常使用，debug 花了很长时间。



 ### 疑惑
无。



 ### 部分效果展示

 **基于结构化流完成业务数据实时分析**：
![Spark-standalone](http://pic.xuecq.cc/hadoopNews-day15-1.png)
**基于结构化流完成业务数据实时分析**：
![Spark-on-yarn](http://pic.xuecq.cc/hadoopNews-day15-2.png)


## day-16

 ### 成果
下载 Tomcat 并创建 Web 工程。

Web 系统数据处理层开发。

基于 Echarts 的页面展示曾开发。

工程编译并打包发布。

确认项目最终效果。



 ### 难点
工程打包时，依赖的处理。

Docker 内 Tomcat 的配置。

修复中文乱码。



 ### 疑惑
无。



 ### 部分效果展示

 **最终效果确认**：
![Final](http://pic.xuecq.cc/hadoopNews-day16-1.png)
