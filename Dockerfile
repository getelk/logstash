FROM jeanblanchard/busybox-java:java7

ENV LS_PKG_NAME logstash-1.4.2
ENV LSCONTRIB_PKG_NAME logstash-contrib-1.4.2

RUN wget http://s3.amazonaws.com/replicated-cdn/logstash/$LS_PKG_NAME.tar.gz -O /tmp/logstash.tar.gz
RUN gunzip /tmp/logstash.tar.gz && tar xvf /tmp/logstash.tar -C /opt && mv /opt/$LS_PKG_NAME /opt/logstash && rm -rf /tmp/logstash.tar

RUN wget http://s3.amazonaws.com/replicated-cdn/logstash/$LSCONTRIB_PKG_NAME.tar.gz -O /tmp/logstash-contrib.tar.gz
RUN gunzip /tmp/logstash-contrib.tar.gz && tar xvf /tmp/logstash-contrib.tar -C /opt && cp -a /opt/$LSCONTRIB_PKG_NAME/ /opt/logstash/ && rm -rf /opt/$LSCONTRIB_PKG_NAME && rm -rf /tmp/logstash-contrib.tar

ADD ./files/start_logstash.sh /usr/local/bin/start_logstash.sh
RUN chmod +x /usr/local/bin/start_logstash.sh
ADD ./files/collectd-types.db /opt/collectd-types.db
ADD ./files/logstash.conf /opt/conf/logstash.conf

VOLUME ["/opt/conf", "/opt/certs"]

EXPOSE 514
EXPOSE 5043
EXPOSE 9292

ENTRYPOINT ["/usr/local/bin/start_logstash.sh"]
