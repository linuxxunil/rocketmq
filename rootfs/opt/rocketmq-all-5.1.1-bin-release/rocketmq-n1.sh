#!/bin/sh
cd /opt/rocketmq/bin

start_namesrv() {
 node=$1
 ./mqnamesrv -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/controller/cluster-2n-namesrv-plugin/namesrv-${node}.conf &	
}

start_broker() {
 node=$1
 ./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/controller/cluster-2n-namesrv-plugin/broker-${node}.conf  --enable-proxy &
}


start() {
 node=$1
 start_namesrv ${node}
 sleep 5
 start_broker ${node}
}

stop() {
./mqshutdown broker
./mqshutdown namesrv
./mqshutdown controller
./mqshutdown proxy
}

export NAMESRV_ADDR='rocketmq-nameserver1:9876;rocketmq-nameserver2:9876'
case "$1" in
 start_broker)
   start_broker n1
 ;;
 start_namesrv)
   start_namesrv n1
 ;;
 start)
   start n1
 ;;
 stop)
   stop
 ;;
 restart)
   stop
   sleep 1
   start
 ;;
 *)
   echo "Usage $0 {start|start_broker|start_namesrv|stop|restart}"
   exit 1
 esac

exit 0

