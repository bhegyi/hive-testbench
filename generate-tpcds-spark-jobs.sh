#!/bin/bash
# 
LOWER_RANGE=$1
UPPER_RANGE=$2
DATABASE=$3

i=$LOWER_RANGE
while [[ $i -le $UPPER_RANGE ]]
do
    spark-submit ./spark-sql-job.py --database ${DATABASE} --file "/opt/hive-testbench/spark-queries-tpcds/q${i}.sql" || true
    ((i = i + 1))
done

