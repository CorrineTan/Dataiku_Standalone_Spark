#!/bin/bash -e

DSS_INSTALLDIR="/home/dataiku/dataiku-dss-$DSS_VERSION"
DSS_DATADIR="/home/dataiku/dss"
DKU_DIR="/home/dataiku"
SPARK_ARCHIVE="dataiku-dss-spark-standalone-8.0.7-2.4.5-generic-hadoop3.tar.gz"

echo "Running DSS Now!"
"$DKU_DIR"/run.sh &

echo "Waiting for everything setting up"
sleep 30

echo "DSS stop now"
"$DSS_DATADIR"/bin/dss stop

echo "Setting up Spark Standalone Integration"
"$DSS_DATADIR"/bin/dssadmin install-spark-integration -standaloneArchive "$DKU_DIR"/"$SPARK_ARCHIVE"

# Wait for spark setup
sleep 15

"$DSS_DATADIR"/bin/dss start
echo "DSS restart now"

# Keep the container running
tail -f /dev/null