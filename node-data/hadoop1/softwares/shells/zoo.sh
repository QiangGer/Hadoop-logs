#!/bin/bash
echo "start zkServer..."
for i in hadoop-1 hadoop-2 hadoop-3
do
ssh $i "source /etc/profile;/opt/modules/zookeeper-3.4.5-cdh5.10.0/sbin/zkServer.sh start"
ssh $i "source /etc/profile;jps"
done

