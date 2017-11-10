#!/usr/bin/env bash

curl -X POST "http://127.0.0.1:${WALLET_PORT}/json_rpc" -d '{"jsonrpc":"2.0","id":"0","method":"query_key","params":{"key_type":"mnemonic"}}' -H 'Content-Type: application/json'
