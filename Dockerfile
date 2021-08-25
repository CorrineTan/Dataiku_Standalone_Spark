FROM dataiku/dss:9.0.4

MAINTAINER Corrine Tan <tenglunt@gmail.com>

USER root

RUN yum update -y && yum install -y wget

ENV SPARK_ARCHIVE "dataiku-dss-spark-standalone-9.0.4-3.0.1-generic-hadoop3.tar.gz"
ENV SPARK_URL "https://downloads.dataiku.com/public/dss/9.0.4/${SPARK_ARCHIVE}"
ENV HADOOP_ARCHIVE "dataiku-dss-hadoop-standalone-libs-generic-hadoop3-9.0.4.tar.gz"
ENV HADOOP_URL "https://downloads.dataiku.com/public/dss/9.0.4/${HADOOP_ARCHIVE}"

RUN wget $SPARK_URL
COPY run-dataiku.sh /home/dataiku/
RUN chown dataiku:dataiku /home/dataiku/run-dataiku.sh
RUN chmod 777 /home/dataiku/run-dataiku.sh

USER dataiku

# ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre/
ENV SPARK_HOME /home/dataiku/dataiku-dss-9.0.4/spark-standalone-home
ENV HADOOP_HOME /home/dataiku/dataiku-dss-9.0.4/hadoop-standalone-home
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_HOME/bin
ENV DKU_DIR /home/dataiku

ENTRYPOINT [ "/home/dataiku/run-dataiku.sh" ]