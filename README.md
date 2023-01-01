## Web Server Assignment

This repository contains the code and configuration for a simple Node.js web server that only accepts GET requests on the path "/foo" and returns a JSON response with the name of the favourite color. The web server is dockerised and the image is used in a Kubernetes deployment file and the "build-and-deploy.sh" script deploys the web server to a minikube cluster and configures the Ingress resource to route requests to the Service.

Have the following installed and configured on your system:
```
- Node.js
- Docker
- minikube
- kubectl
- curl

```


To run the web server locally, run the following commands:

```bash
chmod +x ./build-and-deploy.sh
./build-and-deploy.sh
```

This will build and package the web server application using Docker, apply the Kubernetes configuration files to the minikube cluster using kubectl, and configure the Ingress resource to route requests to the Service. The script will also add an entry to the /etc/hosts file to map the URL http://bar.local to the Service's IP address in the minikube cluster.

Once the web server has been deployed, you can test it by sending a GET request to the URL http://bar.local/foo using the curl tool. You should receive a JSON response with the name of your favourite color.

To stop the web server, delete the deployment and service by running the following command:

```
kubectl delete deployment/web-server service/web-server ingress/web-server
```

Cleaning Up
To stop the minikube cluster and remove all resources, run the following command:

```
minikube stop
killall minikube tunnel
```

#### Assumptions

minikube is already installed and configured with a working default driver
curl is already installed on the system
The minikube cluster has the ingress addon enabled (run minikube addons enable ingress to enable it)

#### Additional Notes

The web server only accepts GET requests on the path "/foo"
The JSON response has the following format: {"myFavouriteColor":<NAME>}, where <NAME> is the name of your favourite color
The web server is deployed to the minikube cluster using a Deployment and a Service, with an Ingress resource routing requests to the Service using the URL http://bar.local/foo
