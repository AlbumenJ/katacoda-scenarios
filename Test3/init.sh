#!/bin/bash

helm init

helm repo add stable https://kubernetes-charts.storage.googleapis.com

helm install stable/docker-registry \
  --name registry \
  --version 1.9.4 \
  --namespace kube-system \
  --set service.port=4567
  --set service.type=ClusterIP \
  --set service.clusterIP=10.98.0.10
  
kubectl port-forward --namespace kube-system \
$(kubectl get po -n kube-system | grep registry-docker-registry | \
awk '{print $1;}') 5000:5000 &

echo "registry.test.training.katacoda.com 10.98.0.10" >> /etc/hosts

export JAVA_HOME=/usr/lib/jvm/default-java