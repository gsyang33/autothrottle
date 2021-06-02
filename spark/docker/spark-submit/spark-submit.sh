#!/bin/bash
IP="10.0.0.22"
/spark/bin/spark-submit \
--class ${SPARK_APPLICATION_MAIN_CLASS} \
--master spark://$IP:7077 \
--deploy-mode client \
--num-executors 1 \
--executor-cores 2 \
--executor-memory 8g \
 ${SPARK_APPLICATION_JAR_LOCATION} \
 ${SPARK_APPLICATION_ARGS1} \
 ${SPARK_APPLICATION_ARGS2} 
