#!/bin/zsh

# Create a new namespace
kubectl create namespace grafana

# Install grafana in created namespace
helm install -n grafana --set grafana.replicaCount=2 grafana-service  bitnami/grafana
sleep 60


kubectl get secret grafana-service-admin --namespace grafana -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}"  | base64 --decode
# Check pods and services
kubectl get pods -n grafana
kubectl get services -n grafana -o wide
kubectl describe service  grafana-service -n grafana
kubectl get endpoints grafana-service -n grafana
kubectl get deployments grafana-service -n grafana

# Test connection
# kubectl port-forward -n grafana svc/grafana-service 8080:3000

kubectl expose deployment grafana-service  -n grafana --type=LoadBalancer  --name=grafana-service-loadbalancer
kubectl get services -n grafana -o wide