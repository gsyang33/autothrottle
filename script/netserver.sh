#!/bin/sh
CN=$1
IP=$2
for i in $(seq 1 $CN)
do
	sudo netserver -p $i -L $2
done
