#!/bin/bash


java -version
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo "Java is set up on machine"
else
  sudo update-alternatives  --install /usr/bin/java java /usr/java/default/bin/java 1
  java -version
fi

javac -version
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo "Javac is set up on machine"
else
  sudo update-alternatives  --install /usr/bin/javac javac /usr/java/default/bin/javac 1
  javac -version
fi

jar -version
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo "jar is set up on machine"
else
  sudo update-alternatives  --install /usr/bin/jar jar /usr/java/default/bin/jar 1
  jar -version
fi

chown -R hive:hadoop /opt/hive-testbench

./tpcds-build.sh
./tpch-build.sh

echo yes | /usr/java/default/bin/keytool -trustcacerts -importcert -alias cmca -file /var/lib/cloudera-scm-agent/agent-cert/cm-auto-in_cluster_ca_cert.pem -keystore /usr/java/default/jre/lib/security/cacerts -storepass changeit

kinit -kt /cdep/keytabs/hive.keytab hive
hdfs dfs -mkdir /user/hive/tpcds
hdfs dfs -mkdir /user/hive/tpch
