Kubernetes cluster has been installed on the nodes. 



The first part of this scenarios is API Server.



`cd ./dubbo-samples-kubernetes-apiserver`{{execute}}



The first stage of using API Server is creating a Service Account for Dubbo.



This Service Account should be granted with the permissions listed below:

- Read and Write permission to Pods
- Read permission to Services
- Read permission to Endpoints



The command below will create a file named `serviceaccount.yml`.

`vi serviceaccount.yml`{{execute}}


Paste these content to the editor.


<pre class="file" data-target="clipboard">
apiVersion: v1
kind: Namespace
metadata:
  name: dubbo-demo
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dubbo-demo
  name: dubbo-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list", "update", "patch"]
- apiGroups: [""] 
  resources: ["services", "endpoints"]
  verbs: ["get", "watch", "list"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: dubbo-sa
  namespace: dubbo-demo
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dubbo-sa-bind
  namespace: dubbo-demo
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: dubbo-role
subjects:
- kind: ServiceAccount
  name: dubbo-sa
</pre>



Close editor and apply it to Kubernetes.

`kubectl apply -f serviceaccount.yml`{{execute}}



Now, we can get Oauth Token from Kubernetes by this command.

`kubectl -n dubbo-demo describe secret $(kubectl -n dubbo-demo get secret | grep dubbo-sa | awk '{print $1}') | grep 'token:' | awk '{print $2}'`{{execute}}



Use the following command to export Token as a environment property.

`export TOKEN=$(kubectl -n dubbo-demo describe secret $(kubectl -n dubbo-demo get secret | grep dubbo-sa | awk '{print $1}') | grep 'token:' | awk '{print $2}')`{{execute}}





Next things we need to get are API Server properties and Nacos ( Config Center ) properties.



API Server properties
`kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}'`{{execute}}



Nacos Host
`kubectl get service -n kube-system | grep nacos | awk '{print $3}'`{{execute}}



Export there properties as environment properties.

`export API_HOST=$(kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}' | sed 's/:/ /g' | sed 's/\// /g' | awk '{print $2}')`{{execute}}

`export API_PORT=$(kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}' | sed 's/:/ /g' | sed 's/\// /g' | awk '{print $3}' | sed 's/[^[:digit:].-]/ /g' | awk '{print $1}')`{{execute}}

`export NAOCS_HOST=$(kubectl get service -n kube-system | grep nacos | awk '{print $3}')`{{execute}}



Now, we can use these environment properties to replace properties files in maven project.

`sed -i 's/\${your kubernetes api server ip here}/'"$API_HOST"'/g' ./src/main/resources/spring/dubbo-consumer.properties && \
sed -i 's/\${your kubernetes api server port here}/'"$API_PORT"'/g' ./src/main/resources/spring/dubbo-consumer.properties && \
sed -i 's/\${your ServiceAccount token here}/'"$TOKEN"'/g' ./src/main/resources/spring/dubbo-consumer.properties && \
sed -i 's/\${your nacos ip here}/'"$NAOCS_HOST"'/g' ./src/main/resources/spring/dubbo-consumer.properties`{{execute}}



`sed -i 's/\${your kubernetes api server ip here}/'"$API_HOST"'/g' ./src/main/resources/spring/dubbo-provider.properties && \
sed -i 's/\${your kubernetes api server port here}/'"$API_PORT"'/g' ./src/main/resources/spring/dubbo-provider.properties && \
sed -i 's/\${your ServiceAccount token here}/'"$TOKEN"'/g' ./src/main/resources/spring/dubbo-provider.properties && \
sed -i 's/\${your nacos ip here}/'"$NAOCS_HOST"'/g' ./src/main/resources/spring/dubbo-provider.properties`{{execute}}

