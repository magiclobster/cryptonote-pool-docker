#!/usr/bin/env bash

if [ "$#" -eq 1 ]; then
    DOMAIN_NAME=${1}
else
    echo "no domain"; exit 1
fi

SS_COUNTRY="DE"
SS_STATE="HH"
SS_COMPANY="magiclobster"
SS_CITY="HH"
SS_ORGA_UNIT="IT"
SS_MAIL="magiclobster@mailbox.org"

SS_KEY_SIZE="4096"
SS_DAYS_VALID="300"
SS_KEY_FILE="${DOMAIN_NAME}.key"
SS_CRT_FILE="${DOMAIN_NAME}.crt"

subj="
C=${SS_COUNTRY}
ST=${SS_STATE}
O=${SS_COMPANY}
localityName=${SS_CITY}
commonName=${DOMAIN_NAME}
organizationalUnitName=${SS_ORGA_UNIT}
emailAddress=${SS_MAIL}
"

cd /cert_scripts && openssl req -batch -subj "$(echo -n "${subj}" | tr "\n" "/")" -nodes -x509 -newkey rsa:${SS_KEY_SIZE} -keyout ${SS_KEY_FILE} -out ${SS_CRT_FILE} -days ${SS_DAYS_VALID}

cat "/cert_scripts/${SS_CRT_FILE}" "/cert_scripts/${SS_KEY_FILE}" >> /etc/letsencrypt/haproxy/${DOMAIN_NAME}_ss.pem
