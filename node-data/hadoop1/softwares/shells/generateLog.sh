#/bin/bash

# 清空原文件
: > /opt/data/weblogs.log

echo "generate logs......"
#第一个参数是原日志文件，第二个参数是日志生成输出文件 第三个参数为读取速度，默认300ms一条
java -jar /opt/data/generateLogs.jar /opt/data/raw.log /opt/data/weblogs.log 300
