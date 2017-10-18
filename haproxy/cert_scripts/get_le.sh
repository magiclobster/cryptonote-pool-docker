#!/usr/bin/env bash

if [ "$#" -eq 1 ]; then
    DOMAIN_NAME=${1}
else
    echo "no domain"; exit 1
fi

cd /cert_scripts && certbot certonly -c /cert_scripts/cli.ini -d ${DOMAIN_NAME}

if [ -f /etc/letsencrypt/haproxy/${DOMAIN_NAME}_ss.pem ]; then
    rm /etc/letsencrypt/haproxy/${DOMAIN_NAME}_ss.pem
fi

cat /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain*.pem /etc/letsencrypt/live/${DOMAIN_NAME}/privkey*.pem >> /etc/letsencrypt/haproxy/${DOMAIN_NAME}.pem
