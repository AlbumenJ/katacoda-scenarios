After deploying the image to registry, we can start Kubernetes deployment.



The command below will create a file named `deploy.yml`.

`vi deploy.yml`{{execute}}


Paste these content to the editor.

<pre class="file" data-target="clipboard">
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: kubernetes-apiserver-demo-provider
spec:
  replicas: 3
  selector:
    matchLabels:
      tier: apiserver-demo-provider
  template:
    metadata:
      labels:
        tier: apiserver-demo-provider
        io.dubbo: MyTest
    spec:
      containers:
      - name: server
        image: registry.test.training.katacoda.com:4567/api-server:v1
        ports:
          - containerPort: 20880
        livenessProbe:
          httpGet:
            path: /live
            port: 22222
          initialDelaySeconds: 5
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /ready
            port: 22222
          initialDelaySeconds: 5
          periodSeconds: 5
        startupProbe:
          httpGet:
            path: /startup
            port: 22222
          failureThreshold: 30
          periodSeconds: 10
---
apiVersion: v1
kind: Service
metadata:
  name: kubernetes-apiserver-demo-provider
spec:
  clusterIP: None
  selector:
    io.dubbo: MyTest
  ports:
    - protocol: TCP
      port: 20880
      targetPort: 20880
</pre>



Close editor and apply it to Kubernetes.

`kubectl apply -n dubbo-demo -f deploy.yml`{{execute}}



After a few seconds wait, the pods are created to Kubernetes Cluster.

`kubectl get pods -n dubbo-demo`{{execute}}

`kubectl get service -n dubbo-demo`{{execute}}