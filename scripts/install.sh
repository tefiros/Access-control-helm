#!/bin/bash

echo "Installing Access Control Helm Chart..."

echo ""

echo "1. Updating Helm dependencies..."
helm dependency update ..
sleep 1
echo "Done"

echo ""

echo "2. Installing Helm Chart..."
helm install access-control ..
sleep 1
echo "Done"

echo ""

echo "All done"
