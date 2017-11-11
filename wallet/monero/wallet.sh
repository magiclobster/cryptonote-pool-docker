#!/usr/bin/env bash

monero-wallet-cli --wallet-file /wallet/${WALLET_NAME} --password ${WALLET_PASSWORD} --daemon-address 127.0.0.1:${WALLETD_PORT}
