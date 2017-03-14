#!/bin/bash
WORKING_DIR=/home/cert_user
HOSTNAME=domain
PRIVKEY_DIR=/path/to/private_key/
#Create account key for let's encrypt
openssl genrsa 4096 > $WORKING_DIR/$HOSTNAME.current.key
#Generate new CSR used for let's encrypt to sign
openssl req -new -key $PRIVKEY_DIR/privkey.pem -out $HOSTNAME.current.csr -config $WORKING_DIR/openssl.cnf
#Remove intermediate cert if it exists
rm -f $WORKING_DIR/intermediate.signed.pem
#Download new intermediate cert
wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > $WORKING_DIR/intermediate.signed.pem
