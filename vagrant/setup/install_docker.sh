#!/bin/bash

echo "alias dl='docker ps -l -q'" >> ~/.bashrc
echo "alias delc='docker rm `docker ps --no-trunc -a -q`'" >> ~/.bashrc
echo "alias delcc='docker kill $(docker ps -q) ; docker rm $(docker ps -a -q)'" >> ~/.bashrc
echo "alias deli='docker images | grep "<none>" | awk '\''{print $3}'\'' | xargs docker rmi'" >> ~/.bashrc
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
