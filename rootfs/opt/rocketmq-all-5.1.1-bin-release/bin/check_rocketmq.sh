#!/bin/sh
/opt/rocketmq/bin/mqadmin brokerStatus -n 'localhost:9876'  -b 'localhost:10911' | grep runtime 

exit $?
