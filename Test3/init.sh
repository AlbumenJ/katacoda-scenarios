#!/bin/bash

launch.sh

helm repo add stable https://kubernetes-charts.storage.googleapis.com

helm install registry stable/docker-registry --version 1.9.4 --namespace kube-system --set service.port=4567 --set service.type=ClusterIP --set service.clusterIP=10.98.0.10

git clone https://github.com/nacos-group/nacos-k8s.git

cd ./nacos-k8s/helm/

helm install nacos . --namespace kube-system --set service.type=ClusterIP --set service.clusterIP=10.99.0.10 
  
cd ~/

echo "10.98.0.10 registry.test.training.katacoda.com" >> /etc/hosts
echo "10.99.0.10 nacos.test.training.katacoda.com" >> /etc/hosts

export JAVA_HOME=/usr/lib/jvm/default-java