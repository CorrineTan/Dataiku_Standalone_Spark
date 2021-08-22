FROM dataiku/dss:8.0.2

MAINTAINER Corrine Tan <tenglunt@gmail.com>

USER root

RUN yum update -y && yum install -y wget

ENV SPARK_ARCHIVE "dataiku-dss-spark-standalone-8.0.7-2.4.5-generic-hadoop3.tar.gz"
ENV SPARK_URL "https://downloads.dataiku.com/public/dss/8.0.7/${SPARK_ARCHIVE}"

RUN wget $SPARK_URL && \
	mkdir -p /opt/spark && \
	tar -xzf $SPARK_ARCHIVE -C /opt/spark --strip-components=1

COPY run-dataiku.sh /home/dataiku/
RUN chown dataiku:dataiku /home/dataiku/run-dataiku.sh
RUN chmod 777 /home/dataiku/run-dataiku.sh

USER dataiku

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre/
ENV PATH $PATH:/opt/spark/bin
ENV DKU_DIR /home/dataiku

ENTRYPOINT [ "/home/dataiku/run-dataiku.sh" ]