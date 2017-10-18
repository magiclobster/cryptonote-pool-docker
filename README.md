# cryptonote-pool-docker
CAUTION: work in progress - use at your own risk

1. git clone https://github.com/magiclobster/cryptonote-pool-docker
2. cd cryptonote-pool-docker
3. edit docker-compose.yml  CHANGE ALL PASSWORDS and TRIPLE check settings
4. docker network create crypto-pool-net
5. docker-compose up -d --build
6. generate lets encrypt certificates:
7.1 docker exec -it haproxy get_le your_domain.xy
7.2 docker kill -s HUP haproxy

THERE IS NO BACKUP, you need to implement your own backup strategy
