#!/bin/bash

apt-get -qq update && \
apt-get install -yq libgoogle-perftools-dev \
build-essential \
libcurl3-dev \
libgeoip-dev \
libpcap-dev \
libssl-dev \
python-dev \
zlib1g-dev \
php5-curl \
git-core \
sendmail \
bison \
cmake \
flex \
gawk \
make \
swig \
curl \
g++ \
gcc --no-install-recommends && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the GeoIPLite Database
cp /vagrant/geoip/* /usr/share/GeoIP/

gunzip /usr/share/GeoIP/GeoLiteCityv6.dat.gz && \
gunzip /usr/share/GeoIP/GeoLiteCity.dat.gz && \
rm -f /usr/share/GeoIP/GeoLiteCityv6.dat.gz && \
rm -f /usr/share/GeoIP/GeoLiteCity.dat.gz && \
ln -s /usr/share/GeoIP/GeoLiteCityv6.dat /usr/share/GeoIP/GeoIPCityv6.dat && \
ln -s /usr/share/GeoIP/GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat

# Install Bro and remove install dir after to conserve space
git clone --recursive git://git.bro.org/bro && \
cd bro && ./configure --prefix=/nsm/bro && \
make && \
make install && \
cd .. && \
rm -rf /bro && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

export PATH=/nsm/bro/bin:$PATH
echo "export PATH=/nsm/bro/bin:$PATH" | sudo tee -a /home/vagrant/.bashrc
echo "export PATH=/nsm/bro/bin:$PATH" | sudo tee -a /home/vagrant/.zshrc
