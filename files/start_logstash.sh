#!/bin/sh

exec /opt/logstash/bin/logstash agent -f /opt/conf/logstash.conf
