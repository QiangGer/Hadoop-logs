#!bash

cd /home/xcq/projects/Hadoop-news

docker-compose stop

docker-compose rm -f

docker rmi hadoop

# 删除日志
rm -rf ./node-data/hadoop1/modules/hadoop-2.5.0/logs

# 删除hdfs存储内容
rm -rf ./node-data/hadoop1/modules/hadoop-2.5.0/data/tmp/*

# 删除slave上的hadoop
rm -rf ./node-data/hadoop2/modules/hadoop-2.5.0/*
rm -rf ./node-data/hadoop3/modules/hadoop-2.5.0/*

# 把主节点的hadoop拷贝过去
cp -rf ./node-data/hadoop1/modules/hadoop-2.5.0/* ./node-data/hadoop2/modules/hadoop-2.5.0
cp -rf ./node-data/hadoop1/modules/hadoop-2.5.0/* ./node-data/hadoop3/modules/hadoop-2.5.0

# 删除zookeeper的日志,保留myid
cd ./node-data/hadoop1/modules/zookeeper-3.4.5-cdh5.10.0/zkData
ls | grep -v myid | xargs -i -t rm -rf {}
cd /home/xcq/projects/Hadoop-news
cd ./node-data/hadoop2/modules/zookeeper-3.4.5-cdh5.10.0/zkData
ls | grep -v myid | xargs -i -t rm -rf {}
cd /home/xcq/projects/Hadoop-news
cd ./node-data/hadoop3/modules/zookeeper-3.4.5-cdh5.10.0/zkData
ls | grep -v myid | xargs -i -t rm -rf {}



