#!/usr/bin/env bash

if [ ! -f /wallet/${WALLET_NAME} ]; then
    echo "wallet.sh not found, creating new wallet.sh"
    echo "1" | monero-wallet-cli --generate-new-wallet ${WALLET_NAME} --password ${WALLET_PASSWORD} > /dev/null &
    sleep 5
fi

if [ "${FORCE_BLOCKCHAIN_DOWNLOAD}" == "true" ]; then
    echo "force blockchain download == true, downloading ..."
    curl --insecure -s -o /tmp/blockchain.raw https://downloads.getmonero.org/blockchain.raw
    monero-blockchain-import --verify 0 --input-file /tmp/blockchain.raw
    rm /tmp/blockchain.raw
fi

monerod --data-dir /wallet/data --rpc-bind-ip 0.0.0.0 --rpc-bind-port ${WALLETD_PORT} --log-file /wallet/walletd.log --confirm-external-bind --non-interactive --detach
sleep 10
exec monero-wallet-cli --wallet-file /wallet/${WALLET_NAME} --password ${WALLET_PASSWORD} --daemon-address 127.0.0.1:${WALLETD_PORT}
