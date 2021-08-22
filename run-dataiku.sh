#!/bin/bash -e

DSS_INSTALLDIR="/home/dataiku/dataiku-dss-$DSS_VERSION"
DSS_DATADIR="/home/dataiku/dss"
DKU_DIR="/home/dataiku"
SPARK_ARCHIVE="dataiku-dss-spark-standalone-8.0.7-2.4.5-generic-hadoop3.tar.gz"

# Let dataiku create /home/dataiku/dss folder first
echo "Running DSS Now!"
"$DKU_DIR"/run.sh &

# Wait for everything's setup
sleep 10
echo "Waiting for everything setting up"

# Stop DSS 
"$DSS_DATADIR"/bin/dss stop
echo "DSS stop now"

# Setup Spark Integration 
"$DSS_DATADIR"/bin/dssadmin install-spark-integration -standaloneArchive "$DKU_DIR"/"$SPARK_ARCHIVE"

# Wait for spark setup
sleep 10

# Start DSS 
"$DSS_DATADIR"/bin/dss start
echo "DSS restart now"

# Keep the container running
tail -f /dev/null