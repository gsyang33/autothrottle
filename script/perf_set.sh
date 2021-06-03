#!/bin/bash
# $1 = conatiner name, $2 = performance goal $3 = the number of vif
NAME=$1
D=`expr 1000 \* $1`
GOAL=`expr $D / 8`
i=$3
W=$4
PID=`docker inspect --format="{{.State.Pid}}" $NAME`
echo $PID > /proc/oslab/vif$i/pid
echo $GOAL > /proc/oslab/vif$i/goal
echo $W > /proc/oslab/vif$i/weight
#echo $GOAL
