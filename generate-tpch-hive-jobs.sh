#!/bin/bash
# ./generate-tpch-hive-jobs.sh 1 5 bhegyi-1.bhegyi.root.hwx.site tpch_text_5
LOWER_RANGE=$1
UPPER_RANGE=$2
HIVE_SERVER=$3
DATABASE=$4

i=$LOWER_RANGE
while [[ $i -le $UPPER_RANGE ]]
do
    beeline -n hive -u "jdbc:hive2://${HIVE_SERVER}:10000/${DATABASE};principal=hive/_HOST@ROOT.HWX.SITE;ssl=True" -f "/opt/hive-testbench/sample-queries-tpch/tpch_query${i}.sql" || true
    ((i = i + 1))
done

