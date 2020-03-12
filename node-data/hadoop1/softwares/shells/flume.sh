#!/bin/bash

#flume的安装根目录（根据自己情况，修改为自己的安装目录）
path=/opt/modules/flume-1.7.0-bin
echo "flume home is :$path"

#flume的进程名称，固定值（不用修改）
JAR="flume"
#flume的配置文件名称（根据自己的情况，修改为自己的flume配置文件名称）
Flumeconf="flume-conf.properties"
#定义的soure名称
agentname="agent1"


function start(){
  echo "begin start flume process ...."
  #查找flume运行的进程数
  num=`ps -ef|grep java|grep $JAR|wc -l` 
  #判断是否有flume进程运行，如果有则运行执行nohup命令
  if [ "$num" = "0" ] ;then
    nohup $path/bin/flume-ng agent --conf conf -f $path/conf/$Flumeconf -n $agentname &
    echo "start success...."
    echo "日志路径: $path/logs/flume.log"
  else
    echo "进程已经存在,启动失败,请检查....."
    exit 0
  fi
}

function stop(){
  echo "begin stop flume process.."
  num=`ps -ef|grep java|grep $JAR|wc -l`
  #echo "$num...."
  if [ "$num" != "0" ];then
  #正常停止flume
  ps -ef|grep java|grep $JAR|awk '{print $2;}'|xargs kill
  echo "进程已经关闭..."
else
  echo "服务未启动，无须停止..."
fi
}

function restart(){
  #echo "begin stop flume process .."
  #执行stop函数
  stop
  #判断程序是否彻底停止
  num='ps -ef|grep java|grep $JAR|wc -l'
  #stop完成之后，查找flume的进程数，判断进程数是否为0，如果不为0，则休眠5秒，再次查看，直到进程数为0
  while [ $num -gt 0 ];do
    sleep 5
    num='ps -ef|grep java|grep $JAR|wc -l'
  done
  echo "flume process stoped,and starting..."
  #执行start
  start
  echo "started...."
}

#case 命令获取输入的参数，如果参数为start,执行start函数，如果参数为stop执行stop函数，如果参数为restart，执行restart函数
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "restart")
    restart
    ;;
  *)
    ;;
esac