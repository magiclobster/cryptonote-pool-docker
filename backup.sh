#!/usr/bin/env bash

BACKUP_PATH="~/crypto-pool-data/"

mkdir -p ${BACKUP_PATH}{redis,wallet}

docker cp aeon-redis:/data/dump.rdb ${BACKUP_PATH}/redis
docker exec -it aeon-wallet ./get_seed > ${BACKUP_PATH}/wallet
