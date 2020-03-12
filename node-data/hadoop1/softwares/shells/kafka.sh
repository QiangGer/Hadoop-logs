#!/bin/bash
echo "start kafka..."

for i in hadoop-1 hadoop-2 hadoop-3
do
ssh $i "source /etc/profile;/opt/modules/kafka_2.11-0.9.0.0/bin/kafka-server-start.sh /opt/modules/kafka_2.11-0.9.0.0/config/server.properties 1>/dev/null 2>&1 &"
done