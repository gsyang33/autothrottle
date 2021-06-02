#!/bin/sh
GOAL=$2
N=`expr 2 \* $1`
for i in $(seq 1 $N)
do
	tcdel c$i --docker --all
	tcset c$i --docker --direction incoming --rate $GOAL
done
