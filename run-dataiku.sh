#!/bin/bash -e

DSS_INSTALLDIR="/home/dataiku/dataiku-dss-$DSS_VERSION"
DSS_DATADIR="/home/dataiku/dss"
DKU_DIR="/home/dataiku"
SPARK_HOME="/opt/spark"
SPARK_ARCHIVE="dataiku-dss-spark-standalone-8.0.7-2.4.5-generic-hadoop3.tar.gz"


# Let dataiku create /home/dataiku/dss folder first
echo "Running DSS Now!"
"$DKU_DIR"/run.sh

# Wait for everything's setup
sleep 30

# Stop DSS 
"$DSS_DATAIR"/bin/dss stop

# Setup Spark Integration 
"$DSS_DATADIR"/bin/dssadmin install-spark-integration -sparkHome "$SPARK_HOME" -standaloneArchive "$DKU_DIR"/"$SPARK_ARCHIVE"

# Wait for spark setup
sleep 15

# Start DSS 
"$DSS_DATAIR"/bin/dss start

# Keep the container running
tail -f /dev/null