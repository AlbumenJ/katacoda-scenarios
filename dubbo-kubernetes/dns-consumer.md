Now, we can start the consumer to consume providers deployed on Kubernetes.



`java -classpath ./target/dubbo-samples-kubernetes-dns-1.0-SNAPSHOT.jar org.apache.dubbo.samples.ConsumerBootstrap`{{execute}}



At the end of the output, you will see `result: hello, Kubernetes DNS` from provider.

