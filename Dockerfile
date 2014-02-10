FROM ubuntu:12.04
MAINTAINER Kazuya Yokogawa "mapk0y@gmail.com"

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -snvf /bin/true /sbin/initctl

RUN echo "deb http://jp.archive.ubuntu.com/ubuntu/ precise main universe" > /etc/apt/sources.list
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y wget openjdk-7-jre-headless

RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main" >>/etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y elasticsearch

EXPOSE 9200
CMD ["/usr/share/elasticsearch/bin/elasticsearch","-f"]
