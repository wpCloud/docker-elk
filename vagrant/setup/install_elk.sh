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
sudo apt-get update && sudo apt-get install elasticsearch logstash -y
sudo update-rc.d elasticsearch defaults 95 10
update-rc.d logstash defaults
curl -s https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz | tar zx -C /opt
mv /opt/kibana-${KIBANA_VERSION} /opt/kibana
# /opt/logstash/bin/logstash -e 'input { stdin { } } output { elasticsearch { host => localhost protocol => "http"} }' &
# /opt/kibana-${KIBANA_VERSION}/bin/kibana
