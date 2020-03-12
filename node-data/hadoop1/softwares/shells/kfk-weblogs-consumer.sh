#/bin/bash

echo "kfk-weblogs-consumer start......"

bin/kafka-console-consumer.sh --zookeeper hadoop-1:2181,hadoop-2:2181,hadoop-3:2181 --from-beginning --topic weblogs
