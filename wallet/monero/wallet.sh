#!/usr/bin/env bash

/wallet/wallet --wallet-file /wallet/${WALLET_NAME} --password ${WALLET_PASSWORD} --daemon-address 127.0.0.1:${WALLETD_PORT}
