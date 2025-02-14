#!/bin/bash

echo "Uninstalling Access Control Helm Chart..."

echo ""

echo "1. Uninstalling Helm Chart..."
helm uninstall access-control
sleep 1
echo "Done"

echo ""

echo "All done"
