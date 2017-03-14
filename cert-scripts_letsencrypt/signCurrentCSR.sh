#!/bin/bash
########################################################
WORKING_DIR=/home/cert_user
HOSTNAME=domain
ACCOUNT_KEY_FILE=$WORKING_DIR/$HOSTNAME.current.key
CSR_FILE=$WORKING_DIR/$HOSTNAME.current.csr
########################################################
#Using your account key, sign your CSR file with let's encrypt to generate your signed certificate
python $WORKING_DIR/acme_tiny.py --account-key $ACCOUNT_KEY_FILE --csr $CSR_FILE --acme-dir $WORKING_DIR/challenges > $WORKING_DIR/$HOSTNAME.current.signed.crt || exit
#Combine the signed certificate with the intermediate certificate to generate your fullchain certificate
cat $WORKING_DIR/$HOSTNAME.current.signed.crt $WORKING_DIR/intermediate.signed.pem > $WORKING_DIR/$HOSTNAME.current.fullchain.pem
sudo service nginx reload