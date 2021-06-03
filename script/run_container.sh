#!/bin/sh
N=`expr 2 \* $1`
for i in $(seq 1 $N)
do
	echo $i
	sudo docker run -idt --name c$i ubuntu:latest
	sudo docker exec c$i apt update
	sudo docker exec c$i apt -y install netperf
done
