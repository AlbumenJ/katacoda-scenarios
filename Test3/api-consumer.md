Now, we can start the consumer to consume providers deployed on Kubernetes.



`java -classpath ./target/dubbo-samples-kubernetes-apiserver-1.0-SNAPSHOT.jar org.apache.dubbo.samples.ConsumerBootstrap`{{execute}}



At the end of the output, you will see `hi` from provider.



At the end of this part, using the following command to clear the environment.



`Ctrl + C`{{execute interrupt}}

`kubectl delete -f deploy.yml -n dubbo-demo`{{execute}}

`cd ../`{{execute}}