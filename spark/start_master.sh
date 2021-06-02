#!/bin/bash
docker-compose -f master.yml up -d
docker-compose -f slaves1.yml up -d
docker-compose -f slaves2.yml up -d
