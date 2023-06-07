#!/bin/sh
cd /opt/rocketmq/bin
start_brokera() {
./mqnamesrv &
sleep 5
./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/2m-2s-sync/broker-a.properties --enable-proxy &
./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/2m-2s-sync/broker-b-s.properties &
}

start_brokerb() {
./mqnamesrv &
sleep 5
./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/2m-2s-sync/broker-b.properties --enable-proxy &
./mqbroker -n 'rocketmq-nameserver1:9876;rocketmq-nameserver2:9876' -c ../conf/2m-2s-sync/broker-a-s.properties &
}

start() {
 export NAMESRV_ADDR=rocketmq-nameserver1:9876;rocketmq-nameserver2:9876
 start_brokerb
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

