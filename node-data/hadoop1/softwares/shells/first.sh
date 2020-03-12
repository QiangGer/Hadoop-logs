#!/bin/bash

echo "start journalnode ..."
for j in hadoop-1 hadoop-2 hadoop-3
do
ssh $j "source /etc/profile;/opt/modules/hadoop-2.5.0/sbin/hadoop-daemon.sh start journalnode"
done


/opt/modules/hadoop-2.5.0/bin/hdfs namenode -format
/opt/modules/hadoop-2.5.0/sbin/hadoop-daemon.sh start namenode

ssh hadoop-2 "source /etc/profile;/opt/modules/hadoop-2.5.0/bin/hdfs namenode -bootstrapStandby"

/opt/modules/hadoop-2.5.0/bin/hdfs zkfc -formatZK
/opt/modules/hadoop-2.5.0/sbin/start-dfs.sh

ssh hadoop-1 "source /etc/profile;/opt/modules/hadoop-2.5.0/sbin/hadoop-daemon.sh start zkfc"
ssh hadoop-2 "source /etc/profile;/opt/modules/hadoop-2.5.0/sbin/hadoop-daemon.sh start zkfc"