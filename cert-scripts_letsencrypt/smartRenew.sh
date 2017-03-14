#!/bin/bash
# The remaining life on our certificate below which we should renew (7 days).
RENEW=7
WORK_DIR=/home/cert_user
SIGNED_CRT=$WORK_DIR/signed.crt
SIGNED_CRT_BACKUP_DIR=$WORK_DIR/backup_signed_crt
# Set date for backup
TODAY=`date '+%Y_%m_%d'`
# If the certificate has less life remaining than we want.
if ! openssl x509 -checkend $[ 86400 * $RENEW ] -noout -in $SIGNED_CRT
        then
                # Then make backup copy of existing cert before starting renew
                cp $SIGNED_CRT $SIGNED_CRT_BACKUP_DIR/signed_backup_$TODAY.crt
                # Then call the renewal script.
                $WORK_DIR/signCurrentCSR.sh 
fi
