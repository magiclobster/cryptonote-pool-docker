#!/usr/bin/env bash

simplewallet --wallet-file /wallet/${WALLET_NAME} --password ${WALLET_PASSWORD} --daemon-address 127.0.0.1:${WALLETD_PORT}
