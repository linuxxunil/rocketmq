#!/bin/sh
cd /opt/rocketmq/bin

nodes_domain='rocketmq-node1:9876;rocketmq-node2:9876;rocketmq-node3:9876'

start_namesrv() {
 node=$1
 ./mqnamesrv -n ${nodes_domain} &
}

start_broker() {
 node=$1
 ./mqbroker  -n ${nodes_domain} -c ../conf/dledger/broker-${node}.conf  --enable-proxy &
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

export NAMESRV_ADDR=${nodes_domain}
case "$1" in
 start_broker)
   start_broker n3
 ;;
 start_namesrv)
   start_namesrv n3
 ;;
 start)
   start n3
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
 ;;
 esac

exit 0

