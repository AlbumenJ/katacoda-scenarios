#!/bin/bash

launch.sh

helm repo add stable https://kubernetes-charts.storage.googleapis.com

helm install registry stable/docker-registry --version 1.9.4 --namespace kube-system --set service.port=4567 --set service.type=ClusterIP --set service.clusterIP=10.98.0.10

echo "10.98.0.10 registry.test.training.katacoda.com" >> /etc/hosts

export JAVA_HOME=/usr/lib/jvm/default-java

git clone https://github.com/Apache/dubbo-samples.git

cd ./dubbo-samples/dubbo-samples-kubernetes

clear

echo "Now you can start your scenario."