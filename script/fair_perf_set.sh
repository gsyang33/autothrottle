#!/bin/sh
# $N = the number of total containers, $2 = performance goal
N=`expr 2 \* $1`
GOAL=$2
for i in $(seq 1 $N)
do
	PID=`docker inspect --format="{{.State.Pid}}" c$i`
	echo $PID > /proc/oslab/vif$i/pid
	echo $GOAL > /proc/oslab/vif$i/goal
done
