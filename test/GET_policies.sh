#!/bin/bash



# Build request URL
REQUEST_URL="http://localhost:31482/policies"

# Perform GET request
echo "Fetching policies from $REQUEST_URL ..."
curl -X GET "$REQUEST_URL" \
  -H "accept: application/json"

echo -e "\n-------------------------"
