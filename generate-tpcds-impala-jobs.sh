#!/bin/bash
# ./generate-tpcds-impala-jobs.sh 1 10 bhegyi-3.bhegyi.root.hwx.site tpcds_text_5

LOWER_RANGE=$1
UPPER_RANGE=$2
IMPALA_DEMON=$3
DATABASE=$4

impala-shell  -i ${IMPALA_DEMON}  -k --ssl -q "INVALIDATE METADATA;"

i=$LOWER_RANGE
while [[ $i -le $UPPER_RANGE ]]
do
    impala-shell  -i ${IMPALA_DEMON} -d ${DATABASE}  -k --ssl -f "/opt/hive-testbench/sample-queries-tpcds/query${i}.sql" || true
    ((i = i + 1))
done

