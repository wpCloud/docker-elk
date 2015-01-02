# -*- mode: ruby -*-
# vi: set ft=ruby :


$INSTALL_DOCKER_AND_ELK = <<SCRIPT
echo "alias dl='docker ps -l -q'" >> ~/.bashrc
echo "alias delc='docker rm `docker ps --no-trunc -a -q`'" >> ~/.bashrc
echo "alias delcc='docker kill $(docker ps -q) ; docker rm $(docker ps -a -q)'" >> ~/.bashrc
echo "alias deli='docker images | grep "<none>" | awk '\''{print $3}'\'' | xargs docker rmi'" >> ~/.bashrc
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
export KIBANA_VERSION=4.0.0-beta3
export ELASTICSEARCH_VERSION=1.4.2
export LOGSTASH_VERSION=1.4.2
curl -s https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz | tar zx -C /opt
curl -s https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz | tar zx -C /opt
curl -s https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz | tar zx -C /opt
/opt/elasticsearch-${ELASTICSEARCH_VERSION}/bin/elasticsearch
/opt/logstash-${LOGSTASH_VERSION}/bin/logstash -e 'input { stdin { } } output { elasticsearch { host => localhost } }'
/opt/kibana-${KIBANA_VERSION}/bin/kibana
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 5601, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.memory = "4096"
  end

  config.vm.provision :shell, inline: 'wget --no-check-certificate https://raw.githubusercontent.com/aglover/ubuntu-equip/master/equip_java8.sh && bash equip_java8.sh'
  config.vm.provision "shell", inline: $INSTALL_DOCKER_AND_ELK

  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline <<-SHELL
  #   sudo apt-get install apache2
  # SHELL
end
