#!/bin/bash
CPUS=2
docker-compose -f a1.yml up -d
docker-compose -f a2.yml up -d
docker-compose -f b1.yml up -d
docker-compose -f b2.yml up -d
docker-compose -f c1.yml up -d
docker-compose -f c2.yml up -d
docker-compose -f d1.yml up -d
docker-compose -f d2.yml up -d

docker update --cpus $CPUS spark-worker1 spark-worker2 spark-worker3 spark-worker4 spark-worker5 spark-worker6 spark-worker7 spark-worker8
