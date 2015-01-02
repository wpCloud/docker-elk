FROM java:8

MAINTAINER blacktop, https://github.com/blacktop

RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d

ENV EL_URL https://download.elasticsearch.org
ENV ELASTICSEARCH_VERSION 1.4.2
ENV KIBANA_VERSION 4.0.0-beta3
ENV LOGSTASH_VERSION 1.4.2

# Install Required Dependancies
RUN \
  apt-get -qq update && \
  apt-get -qy install supervisor nginx && \
  curl -s ${EL_URL}/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
    | tar zx -C /opt && \
  curl -s ${EL_URL}/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz \
    | tar zx -C /opt && \
  curl -s ${EL_URL}/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz \
    | tar zx -C /opt && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Kibana and Configure Nginx
ADD kibana.conf /etc/nginx/sites-available/
RUN \
  mkdir -p /var/www && \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  rm /etc/nginx/sites-enabled/default && \
  ln -s /etc/nginx/sites-available/kibana.conf \
    /etc/nginx/sites-enabled/kibana.conf && \
  ln -s /opt/kibana-$KIBANA_VERSION /var/www/kibana && \
  sed -i 's/5601/80/g' /var/www/kibana/config/kibana.yml && \
  rm kibana-$KIBANA_VERSION.tar.gz

# sed: can't read /var/www/kibana/config.js: No such file or directory
ADD bro.conf /etc/logstash/conf.d/
ADD supervisord.conf /etc/supervisor/conf.d/
ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh

# VOLUME ["/etc/logstash/conf.d"]
# VOLUME ["/opt/kibana-3.1.1/app/dashboards"]
# VOLUME ["/etc/nginx"]

EXPOSE 80 443

ENTRYPOINT /entrypoint.sh

CMD ["/usr/bin/supervisord"]
