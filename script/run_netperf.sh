#!/bin/sh
#$N: total number of containers, $2: message size, $3: IP address of the remote server
N=`expr 2 \* $1`
M=$2
IP=$3
for i in $(seq 1 $N)
do
	sudo docker exec c$i netperf -H $IP -p $i -l 120 -- -m $M > $i.txt &
done
sleep 15
pidstat -C "netperf" 100 1 > cpustat.txt
sleep 10
for i in $(seq 1 $N)
do
	grep -r 64 $i.txt | cut -d" " -f18
done
grep -r Average cpustat.txt | cut -d" " -f33
