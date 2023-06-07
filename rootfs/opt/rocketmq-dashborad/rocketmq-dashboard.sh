#!/bin/sh
cd /opt/rocketmq-dashborad
start() {
	java -jar rocketmq-dashboard-1.0.1-SNAPSHOT.jar &
}


stop() {
	ps aux | grep rocketmq-dashboard-1.0.1-SNAPSHOT.jar | awk '{print $2}' | xargs kill -9
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

