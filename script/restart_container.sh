#!/bin/sh
N=$1
for i in $(seq 1 N)
do
	sudo docker $2 c$i
done
