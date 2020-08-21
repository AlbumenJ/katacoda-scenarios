In order to deploy project to Kubernetes, we need to compile it first, then build a docker image of it and deploy to registry.



### Compile

The example project is based on Maven, and we can compile it with:

`mvn clean package`{{execute}}



### Build Image

The `Dockerfile` has been prepared in current folder.

`cat Dockerfile`



Use this command to build it.

`docker build -t registry.test.training.katacoda.com:4567/api-server:v1 .`{{execute}}



### Deploy to Registry

There is a pre-configure registry prepared during environment start using helm chart.

Use this command to push the image to registry.

`docker push registry.test.training.katacoda.com:4567/api-server:v1`{{execute}}