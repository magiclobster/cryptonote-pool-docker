#!/usr/bin/env bash

BACKUP_PATH="/tmp/backups/crypto-pool"
REDIS_CONTAINER_NAME="cryptonote-redis"
AEON_WALLET_CONTAINER="aeon-wallet"
MONERO_WALLET_CONTAINER="monero-wallet"

mkdir -p ${BACKUP_PATH}/{redis,wallet}

LAST_REDIS_SAVE_TIME=$(docker exec -it ${REDIS_CONTAINER_NAME} redis-cli lastsave | awk '{print $2}' | tr -d '\r')
docker exec -it ${REDIS_CONTAINER_NAME} redis-cli bgsave
REDIS_SAVE_TIME=$(docker exec -it ${REDIS_CONTAINER_NAME} redis-cli lastsave | awk '{print $2}' | tr -d '\r')
sleep 3
if [ ${REDIS_SAVE_TIME} -lt ${LAST_REDIS_SAVE_TIME} ]; then
    echo "WARNING: redis dump may be out of date!"
fi
docker cp ${REDIS_CONTAINER_NAME}:/data/dump.rdb ${BACKUP_PATH}/redis
docker exec -it ${AEON_WALLET_CONTAINER} get_seed | grep key | cut -d ":" -f 2 > ${BACKUP_PATH}/wallet/${AEON_WALLET_CONTAINER}-seed
docker exec -it ${MONERO_WALLET_CONTAINER} get_seed | grep key | cut -d ":" -f 2 > ${BACKUP_PATH}/wallet/${MONERO_WALLET_CONTAINER}-seed
