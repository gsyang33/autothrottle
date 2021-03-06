#!/bin/bash

SPARK_APPLICATION_JAR_LOCATION="/opt/spark-apps/spark-terasort-1.2-SNAPSHOT-jar-with-dependencies.jar"
SPARK_APPLICATION_MAIN_CLASS="com.github.ehiggs.spark.terasort.TeraSort"
SPARK_APPLICATION_ARGS1="file:///opt/spark-apps/data/terasort_in"
SPARK_APPLICATION_ARGS2="file:///opt/spark-apps/data/terasort_out"

START_TIME=`date +%s`
docker run -v $(pwd)/apps:/opt/spark-apps \
--name spark-submit \
--hostname spark-submit \
--network spark_br-n-spark \
--env SPARK_APPLICATION_JAR_LOCATION=$SPARK_APPLICATION_JAR_LOCATION \
--env SPARK_APPLICATION_MAIN_CLASS=$SPARK_APPLICATION_MAIN_CLASS \
--env SPARK_DRIVER_HOST=10.0.0.202 \
--env SPARK_APPLICATION_ARGS1=$SPARK_APPLICATION_ARGS1 \
--env SPARK_APPLICATION_ARGS2=$SPARK_APPLICATION_ARGS2 \
spark-submit:latest
END_TIME=`date +%s`
echo $(($END_TIME - $START_TIME))

docker rm spark-submit
