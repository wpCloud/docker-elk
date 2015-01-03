#!/bin/bash

echo "export KIBANA_VERSION=4.0.0-beta3" >> ~/.bashrc
echo "export ELASTICSEARCH_VERSION=1.4.2" >> ~/.bashrc
echo "export LOGSTASH_VERSION=1.4.2" >> ~/.bashrc
export KIBANA_VERSION=4.0.0-beta3
export ELASTICSEARCH_VERSION=1.4.2
export LOGSTASH_VERSION=1.4.2
wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
sudo add-apt-repository "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main"
curl -s https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz | tar zx -C /opt
logstash -e 'input { stdin { } } output { elasticsearch { host => localhost protocol => "http"} }' &
/opt/kibana-${KIBANA_VERSION}/bin/kibana
