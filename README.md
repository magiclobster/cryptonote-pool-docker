# cryptonote-pool-docker
CAUTION: work in progress - use at your own risk

1. git clone https://github.com/magiclobster/cryptonote-pool-docker
2. cd cryptonote-pool-docker
3. edit docker-compose.yml  CHANGE ALL PASSWORDS and TRIPLE check settings
4. docker-compose up -d --build
5. generate lets encrypt certificates:
5.1 docker exec -it haproxy get_le your_domain.xy
5.2 docker kill -s HUP haproxy

THERE IS NO BACKUP, you need to implement your own backup strategy
