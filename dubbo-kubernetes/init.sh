#!/bin/bash

launch.sh

helm repo add stable https://kubernetes-charts.storage.googleapis.com

helm install registry stable/docker-registry --version 1.9.4 --namespace kube-system --set service.port=4567 --set service.type=ClusterIP --set service.clusterIP=10.98.0.10

echo "10.98.0.10 registry.test.training.katacoda.com" >> /etc/hosts

export JAVA_HOME=/usr/lib/jvm/default-java

git clone https://github.com/AlbumenJ/dubbo-samples.git

cd ./dubbo-samples

git checkout 3.0-kubernetes

cd ./java/dubbo-samples-kubernetes

clear

echo "Now you can start your scenario."