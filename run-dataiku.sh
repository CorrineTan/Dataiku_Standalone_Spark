#!/bin/bash -e

DSS_INSTALLDIR="/home/dataiku/dataiku-dss-9.0.4"
DSS_DATADIR="/home/dataiku/dss"
DKU_DIR="/home/dataiku"
SPARK_ARCHIVE="dataiku-dss-spark-standalone-9.0.4-3.0.1-generic-hadoop3.tar.gz"

echo "Running DSS Now!"
"$DKU_DIR"/run.sh &

echo "Waiting for everything setting up"
sleep 30

echo "DSS stop now"
"$DSS_DATADIR"/bin/dss stop

echo "Setting up Spark Standalone Integration"
"$DSS_DATADIR"/bin/dssadmin install-spark-integration -standaloneArchive "$DKU_DIR"/"$SPARK_ARCHIVE"
"$DSS_DATADIR"/bin/dssadmin install-hadoop-integration -standaloneArchive "$DKU_DIR"/"$HADOOP_ARCHIVE"

# Wait for spark setup
sleep 15

"$DSS_DATADIR"/bin/dss start
echo "DSS restart now"

# Keep the container running
tail -f /dev/null