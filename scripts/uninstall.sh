#!/bin/bash

echo "Uninstalling Access Control Helm Chart..."

echo ""

echo "1. Uninstalling Helm Chart..."
helm uninstall access-control
sleep 1
echo "Done"

echo ""

echo "2. Deleting PersistentVolumeClaims..."
kubectl get pvc -n default --no-headers=true | awk '/data-access-control/{print $1}' | xargs kubectl delete -n default pvc
sleep 1
echo "Done"

echo ""

echo "All done"
