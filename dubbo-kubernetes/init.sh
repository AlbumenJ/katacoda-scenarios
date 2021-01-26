#!/bin/bash

launch.sh

docker run -d -p 4567:5000 -v /opt/registry/data:/var/lib/registry --name registry registry:2

echo "[[HOST_IP]] registry.test.training.katacoda.com" >> /etc/hosts

export JAVA_HOME=/usr/lib/jvm/default-java

git clone https://github.com/Apache/dubbo-samples.git

cd ./dubbo-samples/dubbo-samples-kubernetes

clear

echo "Now you can start your scenario."