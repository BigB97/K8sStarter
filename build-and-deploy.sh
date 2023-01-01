#!/bin/bash

# point your shell to minikube's docker daemon
echo "--Pointing shell to minikube's docker daemon..."
eval $(minikube docker-env)
# docker push web-server:latest

# space out the output
echo

# Build the Docker image
echo "--Building Docker image..."
docker build -t web-server:latest .

# space out the output
echo

# Deploy the web server to the minikube cluster
echo "--Apply all manifests in the k8s directory..."
kubectl apply -f k8s

# space out the output
echo

# Wait for the deployment to be ready
echo "--Waiting for deployment to be ready..."
kubectl rollout status deployment/web-server

# space out the output
echo

# Create the minikube tunnel to expose the 
# Add an entry to /etc/hosts for bar.local to point to the service IP
# The service IP is the IP the `minikube tunnel` will use to expose the service
echo "--Adding entry to /etc/hosts..."
SERVICE_IP="127.0.0.1"
# check if the "$SERVICE_IP bar.local" entry already exists in /etc/hosts
if grep -q "$SERVICE_IP bar.local" /etc/hosts; then
    echo "Entry already exists in /etc/hosts" 
elif grep -q "$SERVICE_IP" /etc/hosts; then
    # if the entry exists but doesn't have the correct domain name, remove it
    sudo sed -i '' "/$SERVICE_IP/d" /etc/hosts
    echo "$SERVICE_IP bar.local" | sudo tee -a /etc/hosts
else
    # if the entry doesn't exist, add it
    echo "$SERVICE_IP bar.local" | sudo tee -a /etc/hosts
fi

# space out the output
echo

# Kill the minikube tunnel if it's already running
echo "--Killing minikube tunnel if it's already running..."
killall minikube tunnel 

echo
echo

# Start the minikube tunnel
echo "--Starting minikube tunnel..."
echo "  You may be prompted for your password to add an entry to /etc/hosts"
minikube tunnel &


sleep 15


# space out the output
echo 
echo


# Open the web server in a browser
echo "--Runnin curl to test the web server..."
echo
curl http://bar.local/foo

# space out the output
echo

echo "--You can now open http://bar.local/foo in your browser to see the web server"
echo
