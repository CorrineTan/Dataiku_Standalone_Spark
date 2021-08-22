#!/bin/bash -e

DSS_INSTALLDIR="/home/dataiku/dataiku-dss-$DSS_VERSION"
DSS_DATADIR="/home/dataiku/dss"
DKU_DIR="/home/dataiku"
SPARK_HOME="/opt/spark"
SPARK_ARCHIVE="dataiku-dss-spark-standalone-8.0.7-2.4.5-generic-hadoop3.tar.gz"

if [ ! -f "$DSS_DATADIR"/bin/env-default.sh ]; then
	# Initialize new data directory
	"$DSS_INSTALLDIR"/installer.sh -d "$DSS_DATADIR" -p "$DSS_PORT"
	"$DSS_DATADIR"/bin/dssadmin install-R-integration
	"$DSS_DATADIR"/bin/dssadmin install-spark-integration -sparkHome $SPARK_HOME -standaloneArchive $DKU_DIR/$SPARK_ARCHIVE
	echo "dku.registration.channel=docker-image" >>"$DSS_DATADIR"/config/dip.properties

elif [ $(bash -c 'source "$DSS_DATADIR"/bin/env-default.sh && echo "$DKUINSTALLDIR"') != "$DSS_INSTALLDIR" ]; then
	# Upgrade existing data directory
	"$DSS_INSTALLDIR"/installer.sh -d "$DSS_DATADIR" -u -y
	"$DSS_DATADIR"/bin/dssadmin install-R-integration
	"$DSS_DATADIR"/bin/dssadmin install-spark-integration -sparkHome $SPARK_HOME -standaloneArchive $DKU_DIR/$SPARK_ARCHIVE

fi

exec "$DSS_DATADIR"/bin/dss run