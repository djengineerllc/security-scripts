#!/bin/bash
WORKING_DIR=/home/cert_user
HOSTNAME=domain
#Remove current pin key if it already exists
rm -f $WORKING_DIR/$HOSTNAME.current.pinkey
#Generate new pin key from the current CSR file
openssl x509 -pubkey < $WORKING_DIR/$HOSTNAME.current.fullchain.pem | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | base64 > $WORKING_DIR/$HOSTNAME.current.pinkey

#Remove backup1 pin key if it already exists
rm -f $WORKING_DIR/$HOSTNAME.first.pinkey
#Generate new pin key from the backup1 CSR file
openssl req -pubkey < $WORKING_DIR/$HOSTNAME.first.csr | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | base64 > $WORKING_DIR/$HOSTNAME.first.pinkey

#Remove backup2 pin key if it already exists
rm -f $WORKING_DIR/$HOSTNAME.second.pinkey
#Generate new pin key from the backup2 CSR file
openssl req -pubkey < $WORKING_DIR/$HOSTNAME.second.csr | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | base64 > $WORKING_DIR/$HOSTNAME.second.pinkey