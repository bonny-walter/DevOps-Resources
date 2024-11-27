#!/bin/bash
# Kubernetes Status Check Script

echo "Checking Kubernetes cluster status..."

echo "Pods status:"
kubectl get pods --all-namespaces -o wide

echo "Nodes status:"
kubectl get nodes

echo "Status check completed!"
