The second part of this scenarios is DNS.



`cd ./dubbo-samples-kubernetes-dns`{{execute}}



The properties should be configured in DNS registry are DNS hostname and Nacos (Config Center) address.



DNS hostname:

`kubectl get service -n kube-system | grep kube-dns | awk '{print $3}'`{{execute}}



Export it as environment properties.

`export DNS_HOST=$(kubectl get service -n kube-system | grep kube-dns | awk '{print $3}')`{{execute}}



Now, we can use these environment properties to replace properties files in maven project.

`sed -i 's/\${your kube dns ip here}/'"$DNS_HOST"'/g' ./src/main/resources/spring/dubbo-consumer.properties`{{execute}}

`sed -i 's/\${your kube dns ip here}/'"$DNS_HOST"'/g' ./src/main/resources/spring/dubbo-provider.properties`{{execute}}