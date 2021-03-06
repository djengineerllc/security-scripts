#!/bin/bash
WORKING_DIR=/home/cert_user
HOSTNAME=domain
PRIVKEY_DIR=/path/to/private_key/
#Create account key for let's encrypt
openssl genrsa -out $WORKING_DIR/$HOSTNAME.second.key 4096
#Generate new CSR used for let's encrypt to sign
openssl req -new -key $WORKING_DIR/$HOSTNAME.second.key -sha256 -out $HOSTNAME.second.csr -config $WORKING_DIR/openssl.cnf
#Remove intermediate cert if it exists
rm -f $WORKING_DIR/intermediate.signed.pem
#Download new intermediate cert
wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > $WORKING_DIR/intermediate.signed.pem
