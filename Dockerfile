FROM ubuntu:12.04
MAINTAINER Kazuya Yokogawa "mapk0y@gmail.com"

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -snvf /bin/true /sbin/initctl

RUN echo "deb http://jp.archive.ubuntu.com/ubuntu/ precise main universe" > /etc/apt/sources.list
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y git wget vim ca-certificates openjdk-7-jre

ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
ENV ELASTIC_SEARCH_VERSION 0.90.11
RUN (cd /tmp;wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTIC_SEARCH_VERSION}.deb)
RUN dpkg -i elasticsearch-${ELASTIC_SEARCH_VERSION}.deb
RUN echo "export JAVA_HOME=${JAVA_HOME} >>/etc/default/elasticsearch

RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/1.6.0
RUN /usr/share/elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ

#ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

EXPOSE 9200
CMD ["/usr/share/elasticsearch/bin/elasticsearch","-f"]
