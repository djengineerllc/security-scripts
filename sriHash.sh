#!/bin/bash
FILE=$1
HASH=$(openssl dgst -sha384 -binary $FILE | openssl base64 -A)
echo "sha384-${HASH}"