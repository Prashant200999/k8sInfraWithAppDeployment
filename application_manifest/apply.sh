#!/bin/bash

# Apply Kubernetes resources
kubectl apply -f mysql-configmap.yml
kubectl apply -f persistent-volume.yml
kubectl apply -f statefulsets.yml
kubectl apply -f mysql-secrets.yml
kubectl apply -f mysql-service.yml
kubectl apply -f frontend-deployment.yml
kubectl apply -f frontend-service.yml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f ingress.yml


# Wait for Ingress to get external IP
echo "Waiting for Ingress to get an external IP..."
sleep 15 # Wait for the load balancer to provision, adjust this if needed

# Get the external IP of the Ingress
EXTERNAL_IP=$(kubectl get svc frontend-app-service -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$EXTERNAL_IP" ]; then
    echo "Load balancer external IP is not yet available. Try again later."
    exit 1
fi

echo "External IP of the Load Balancer: $EXTERNAL_IP"

# Run dig to get the IP
echo "Running dig command to resolve IP..."
sleep 60
dig +short $EXTERNAL_IP
