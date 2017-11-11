#!/usr/bin/env bash

sed -i "s/°POOL_COIN°/${POOL_COIN}/g" /pool/config.json
sed -i "s/°POOL_SYMBOL°/${POOL_SYMBOL}/g" /pool/config.json
sed -i "s/°POOL_FEE°/${POOL_FEE}/g" /pool/config.json
sed -i "s/°POOL_WALLET_ADDRESS°/${POOL_WALLET_ADDRESS}/g" /pool/config.json
sed -i "s/°POOL_API_PASSWORD°/${POOL_API_PASSWORD}/g" /pool/config.json
sed -i "s/°POOL_HOST°/${POOL_HOST}/g" /pool/website/config.js
sed -i "s/°POOL_API°/${POOL_API}/g" /pool/website/config.js
sed -i "s/°MAIL_ADDRESS°/${MAIL_ADDRESS}/g" /pool/website/config.js

service nginx start && exec node init.js -config=config.json

