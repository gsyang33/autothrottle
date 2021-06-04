#!/bin/bash
IPADDRESS=$1
docker network create --gateway $IPADDRESS.1 --subnet $IPADDRESS.0/16 spark_br-n-spark
