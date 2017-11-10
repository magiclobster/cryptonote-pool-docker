#!/usr/bin/env bash

BACKUP_PATH="/tmp/backups/crypto-pool"

mkdir -p ${BACKUP_PATH}/{redis,wallet}

LAST_REDIS_SAVE_TIME=$(docker exec -it aeon-redis redis-cli lastsave | awk '{print $2}' | tr -d '\r')
docker exec -it aeon-redis redis-cli bgsave
REDIS_SAVE_TIME=$(docker exec -it aeon-redis redis-cli lastsave | awk '{print $2}' | tr -d '\r')
sleep 3
if [ ${REDIS_SAVE_TIME} -lt ${LAST_REDIS_SAVE_TIME} ]; then
    echo "WARNING: redis dump may be out of date!"
fi
docker cp aeon-redis:/data/dump.rdb ${BACKUP_PATH}/redis
docker exec -it aeon-wallet get_seed | grep key | cut -d ":" -f 2 > ${BACKUP_PATH}/wallet/aeon-wallet-seed
