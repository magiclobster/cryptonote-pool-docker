#!/usr/bin/env bash

LE_CERT_DIR=/etc/letsencrypt/live/
HA_CERT_DIR=/etc/letsencrypt/haproxy/

for d in ${LE_CERT_DIR}*/; do
    if [ -f ${d}fullchain*.pem ] && [ ${d}privkey*.pem ]; then
        cat ${d}fullchain*.pem ${d}privkey*.pem > ${HA_CERT_DIR}$(basename ${d}).pem
    else
        echo "missing or wrong name for cert/private key in: ${d}"
    fi
done
