#!/usr/bin/env bash

BACKUP_PATH="~/crypto-pool-data/"

mkdir -p ${BACKUP_PATH}{redis,wallet}

docker cp aeon-redis:/data/dump.rdb ${BACKUP_PATH}/redis
docker cp aeon-wallet:/wallet/pool.* ${BACKUP_PATH}/wallet