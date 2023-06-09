#!/bin/sh
cd /opt/rocketmq/bin

start_n1() {
./mqnamesrv -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/controller/cluster-2n-namesrv-plugin/namesrv-n1.conf &	
sleep 5
./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/controller/cluster-2n-namesrv-plugin/broker-n1.conf  --enable-proxy &
}

start_n2(){
./mqnamesrv -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/controller/cluster-2n-namesrv-plugin/namesrv-n2.conf &
sleep 5
./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/controller/cluster-2n-namesrv-plugin/broker-n2.conf  --enable-proxy &
}


start() {
 export NAMESRV_ADDR='rocketmq-nameserver1:9876;rocketmq-nameserver2:9876'
 start_n2
}

stop() {
./mqshutdown broker
./mqshutdown namesrv
./mqshutdown controller
./mqshutdown proxy
}

case "$1" in
 start)
   start
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
   echo "Usage $0 {start|stop|restart}"
   exit 1
 esac

exit 0

