# Hadoop-logs

这是一个 **正在开发的** 基于分布式大数据平台的日志存储分析处理及可视化系统



项目进度见：[项目日志](./project-diary.md)



## 需求分析

- 搭建分布式大数据平台( Hadoop, Yarn, ZooKeeper, Docker )。

- 收集( Flume )网站日志数据( 暂定使用 搜狗实验室 的新闻网站数据 )。

- 实时处理数据( Kafka, Spark )并在前端( Echarts )做展示( 实时热度TopK等 )。

- 数据清洗后存储到数据仓库中( Hbase, Hive )。

- 离线处理数据( MapReduce )后提供交互式报表( Hue )( 统计不同时段对应的访问量等数据 )。



## 架构

**待补充**



## 节点情况

|           |            机器1            |            机器2            |    机器3     |
| :-------: | :-------------------------: | :-------------------------: | :----------: |
|   HDFS    |      NameNode/DataNode      |      NameNode/DataNode      |   DataNode   |
|   YARN    | ResourceManager/NodeManager | ResourceManager/NodeManager | NodeManager  |
| ZooKeeper |          ZooKeeper          |          ZooKeeper          |  ZooKeeper   |
|   Kafka   |            Kafka            |            Kafka            |    Kafka     |
|   Hbase   |     master/RegionServer     |        RegionServer         | RegionServer |
|   Flume   |            Flume            |            Flume            |    Flume     |
|   Hive    |                             |                             |     Hive     |
|   Mysql   |                             |                             |    Mysql     |
|   Spark   |                             |            Spark            |              |
|    Hue    |                             |                             |     Hue      |



## 使用说明

1. 配置 ssh 免密登陆 

   ``` shell
   # 注意，这是初始化时才要做的，只需配置一次即可。hadoop-1 和 hadoop-2 都需要做
   ./opt/tools/autoSsh.sh
   ```

2. 启动 ZooKeeper 集群

   ``` shell
   # 在 hadoop-1 上单独启动集群，下面的命令无特殊说明均在 hadoop-1 上执行
   ./opt/tools/zoo.sh
   ```

3. 启动 JournalNode 集群 

4. 选择一个节点作为 NameNode 格式化并启动

5. 在备用名称节点上同步 NameNode 

6. 选择一个节点格式化 ZooKeeper 

7. 启动 HDFS 

8. 启动 zkfc

   ``` bash
   # 3 - 8 步以及集成在 first.sh 中，方便集群创建后的初始化
   ./opt/tools/first.sh
   # 若非首次使用，则无需进行格式化，直接启动 HDFS 和zkfc 即可
   ./opt/modules/hadoop-2.5.0/sbin/start-dfs.sh
   # zkfc 需在 hadoo-1 和 hadoop-2 上执行
   ./opt/modules/hadoop-2.5.0/sbin/hadoop-daemon.sh start zkfc 
   ```

9. 启动 Yarn 集群（需手动启动备用 ResourceManager ）

   ``` bash
   ./opt/modules/hadoop-2.5.0/sbin/start-yarn.sh
   # 去另一节点（hadoop-2）
   ./opt/modules/hadoop-2.5.0/sbin/yarn-daemon.sh start resourcemanager    
   ```

10. 启动日志聚合服务

    ``` shell
    ./opt/modules/hadoop-2.5.0/sbin/hadoop-daemon.sh start historyserver
    ```

11. 启动 Hbase

    ``` shell
    ./opt/modules/hbase-0.98.6-cdh5.3.0/bin/start-hbase.sh
    # 略去建表等操作
    ```

12. 启动 Kafka

    ``` shell
    ./opt/tools/kafka.sh
    ```

13. 启动 Flume

    ``` shell
    # 每个节点都要单独做，因为不同节点的 Flume 功能不同
    ./opt/modules/flume-1.7.0-bin/flume.sh start
    ```

14. 开始生产并记录日志

    ``` shell
    # hadoop-2 和 hadoop-3 去产生日志
    ./opt/tools/generateLog.sh
    # hadoop-1 可以通过 Kafka 的消费端或 Hbase shell 去验证结果 
    ./opt/modules/kafka_2.11-0.9.0.0/kfk-weblogs-consumer.sh
    ./opt/modules/hbase-0.98.6-cdh5.3.0/bin/hbase shell
    ```


15. Hive 创建外部表

    ``` bash
    # Hive 配置成依赖 Mysql，注意检查 Mysql 是否启动，启动后，在 hadoop-3 上初始化 Hive 
    ./opt/modules/hive-0.13.1-cdh5.3.6/bin/hive
    # 创建和 weblogs 对应的表结构
    CREATE EXTERNAL TABLE weblogs(
    id string,
    datetime string,
    userid string,
    searchname string,
    retorder string,
    cliorder string,
    cliurl string
    )
    STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
    WITH SERDEPROPERTIES("hbase.columns.mapping"=
    ":key,info:datetime,info:userid,info:searchname,info:retorder,info:cliorder,info:cliurl")
    TBLPROPERTIES("hbase.table.name"="weblogs");
    # 接下来可以运行相应的 sql 语句进行检查
    ```

16. 启动 Hive 的后台服务

    ``` shell
    # 若想在 Hue 中使用 Hive，需在后台开启相应的 Hive 进程
    nohup ./opt/modules/hive-0.13.1-cdh5.3.6/bin/hiveserver2 &
    ```

17. 编译 Hue

    ``` shell
    # 确保编译相关的依赖正常后再编译，相关依赖在 conf 目录下
    cd /opt/modules/hue-3.7.0-cdh5.3.6
    make apps
    # 修改 desktop.db 文件权限和所属用户
    chmod o+w desktop/desktop.db
    # 启动 Hue 服务
    ./opt/modules/hue-3.9.0-cdh5.5.0/build/env/bin/supervisor
    # 之后便可前往浏览器访问了 http://hadoop-3:8888
    ```

## 待完善

