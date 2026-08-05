#!/bin/bash


# Ask for the file to upload
read -p "Enter the filename to upload: " FILE_TO_UPLOAD

# Check if the file exists
if [ ! -f "$FILE_TO_UPLOAD" ]; then
  echo "Error: The file $FILE_TO_UPLOAD does not exist."
  exit 1
fi

# Build upload URL
UPLOAD_URL="http://localhost:31482/policies"

# Upload the file
echo "Uploading file $FILE_TO_UPLOAD to $UPLOAD_URL ..."
curl -X POST "$UPLOAD_URL" \
  -F "file=@$FILE_TO_UPLOAD"

echo -e "\n-------------------------"


