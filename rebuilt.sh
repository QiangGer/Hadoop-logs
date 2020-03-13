#!bash

# 此脚本需要再优雅些，凑合先用

cd /home/xcq/projects/Hadoop-news

docker-compose stop

docker-compose rm -f

docker rmi hadoop

# 删除日志
rm -rf ./node-data/hadoop1/modules/hadoop-2.5.0/logs

# 删除hdfs存储内容
rm -rf ./node-data/hadoop1/modules/hadoop-2.5.0/data/tmp/*
rm -rf ./node-data/hadoop1/modules/hadoop-2.5.0/data/jn/*

# 删除slave上的hadoop
rm -rf ./node-data/hadoop2/modules/hadoop-2.5.0/*
rm -rf ./node-data/hadoop3/modules/hadoop-2.5.0/*

# 把主节点的hadoop拷贝过去
cp -rf ./node-data/hadoop1/modules/hadoop-2.5.0/* ./node-data/hadoop2/modules/hadoop-2.5.0
cp -rf ./node-data/hadoop1/modules/hadoop-2.5.0/* ./node-data/hadoop3/modules/hadoop-2.5.0


# 删除zookeeper的缓存,保留myid
cd ./node-data/hadoop1/modules/zookeeper-3.4.5-cdh5.10.0/zkData
ls | grep -v myid | xargs -i -t rm -rf {}


cd /home/xcq/projects/Hadoop-news
cd ./node-data/hadoop2/modules/zookeeper-3.4.5-cdh5.10.0/zkData
ls | grep -v myid | xargs -i -t rm -rf {}


cd /home/xcq/projects/Hadoop-news
cd ./node-data/hadoop3/modules/zookeeper-3.4.5-cdh5.10.0/zkData
ls | grep -v myid | xargs -i -t rm -rf {}

for i in hadoop1 hadoop2 hadoop3
do
  rm -rf /home/xcq/projects/Hadoop-news/node-data/$i/modules/hbase-0.98.6-cdh5.3.0/logs/*
  rm -rf /home/xcq/projects/Hadoop-news/node-data/$i/modules/kafka_2.11-0.9.0.0/kafka-logs/*
  rm -rf /home/xcq/projects/Hadoop-news/node-data/$i/modules/kafka_2.11-0.9.0.0/logs/*
  rm -rf /home/xcq/projects/Hadoop-news/node-data/$i/modules/flume-1.7.0-bin/nohup.out
  rm -rf /home/xcq/projects/Hadoop-news/node-data/$i/modules/flume-1.7.0-bin/logs/*
done

# 清空日志文件
: > /home/xcq/projects/Hadoop-news/node-data/hadoop2/data/weblogs.log
: > /home/xcq/projects/Hadoop-news/node-data/hadoop3/data/weblogs.log


# # 删除 hbase 日志
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop1/modules/hbase-0.98.6-cdh5.3.0/logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop2/modules/hbase-0.98.6-cdh5.3.0/logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop3/modules/hbase-0.98.6-cdh5.3.0/logs/*

# # 删除 kafka 日志
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop1/modules/kafka_2.11-0.9.0.0/kafka-logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop1/modules/kafka_2.11-0.9.0.0/logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop2/modules/kafka_2.11-0.9.0.0/kafka-logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop2/modules/kafka_2.11-0.9.0.0/logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop3/modules/kafka_2.11-0.9.0.0/kafka-logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop3/modules/kafka_2.11-0.9.0.0/logs/*

# # 删除 flume 日志
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop1/modules/flume-1.7.0-bin/nohup.out
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop2/modules/flume-1.7.0-bin/nohup.out
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop3/modules/flume-1.7.0-bin/nohup.out
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop1/modules/flume-1.7.0-bin/logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop2/modules/flume-1.7.0-bin/logs/*
# rm -rf /home/xcq/projects/Hadoop-news/node-data/hadoop3/modules/flume-1.7.0-bin/logs/*

