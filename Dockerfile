FROM dataiku/dss:8.0.2

MAINTAINER Corrine Tan <tenglunt@gmail.com>

USER root

RUN apt-get update && apt-get install -y wget

ENV SPARK_ARCHIVE "dataiku-dss-spark-standalone-8.0.7-2.4.5-generic-hadoop3.tar.gz"
ENV SPARK_URL "https://downloads.dataiku.com/public/dss/8.0.7/${SPARK_ARCHIVE}"

RUN wget $SPARK_URL && \
	mkdir -p /opt/spark && \
	tar -xzf $SPARK_ARCHIVE -C /opt/spark --strip-components=1

COPY run.sh /home/dataiku/
RUN chown dataiku:dataiku /home/dataiku/run.sh

USER dataiku

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre/
ENV PATH $PATH:/opt/spark/bin
ENV SPARK_HOME /opt/spark

CMD [ "/home/dataiku/run.sh" ]