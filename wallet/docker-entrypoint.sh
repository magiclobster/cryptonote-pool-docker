#!/usr/bin/env bash

if [ ! -f /wallet/${WALLET_NAME} ]; then
    echo "wallet not found, creating new wallet"
    echo "exit" | /wallet/wallet --generate-new-wallet ${WALLET_NAME} --password ${WALLET_PASSWORD} > /dev/null &
    sleep 5
fi

./walletd --data-dir data --rpc-bind-ip 0.0.0.0 --rpc-bind-port ${WALLETD_PORT} --log-file /wallet/walletd.log --no-console --no-igd &> /dev/null &
sleep 10
exec /wallet/wallet --wallet-file /wallet/${WALLET_NAME} --password ${WALLET_PASSWORD} --rpc-bind-ip 0.0.0.0 --rpc-bind-port ${WALLET_PORT} --daemon-address 127.0.0.1:${WALLETD_PORT}

