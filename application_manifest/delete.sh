#!/bin/bash

kubectl delete -f ingress.yml
kubectl delete -f frontend-service.yml
kubectl delete -f frontend-deployment.yml
kubectl delete -f mysql-service.yml
kubectl delete -f mysql-secrets.yml
kubectl delete -f statefulsets.yml
kubectl delete -f persistent-volume.yml
kubectl delete -f mysql-configmap.yml
kubectl delete pvc mysql-data-mysql-0

echo "All resources have been deleted."
