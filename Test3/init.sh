#!/bin/bash

launch.sh

helm repo add stable https://kubernetes-charts.storage.googleapis.com

helm install registry stable/docker-registry \
  --version 1.9.4 \
  --namespace kube-system \
  --set service.port=4567 \
  --set service.type=ClusterIP \
  --set service.clusterIP=10.98.0.10
  
nohup kubectl port-forward --namespace kube-system \
$(kubectl get po -n kube-system | grep registry-docker-registry | \
awk '{print $1;}') 4567:4567 >/dev/null 2>&1 &

echo "10.98.0.10 registry.test.training.katacoda.com" >> /etc/hosts

export JAVA_HOME=/usr/lib/jvm/default-java

clear