#!/bin/sh
N=`expr $1 - 1`
DEV=$2
F=`expr 32768 / $1`
echo 32768 > /proc/sys/net/core/rps_sock_flow_entries
for i in $(seq 0 $N)
do
	echo $F > /sys/class/net/$DEV/queues/rx-$i/rps_flow_cnt
done
