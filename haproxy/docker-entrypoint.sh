#!/usr/bin/env bash

if [ ! -f /etc/letsencrypt/haproxy/${AEON_WEB_DOMAIN}.pem ]; then
    echo "ssl cert missing, creating self signed"
    create_ss ${AEON_WEB_DOMAIN}
fi

if [ ! -f /etc/letsencrypt/haproxy/${MOONER_WEB_DOMAIN}.pem ]; then
    echo "ssl cert missing, creating self signed"
    create_ss ${MOONERO_WEB_DOMAIN}
fi

sed -i "s/°AEON_WEB_DOMAIN°/${AEON_WEB_DOMAIN}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_WEB_DOMAIN°/${MONERO_WEB_DOMAIN}/g" /usr/local/etc/haproxy/haproxy.cfg

sed -i "s/°HAPROXY_STATS_PASSWORD°/${HAPROXY_STATS_PASSWORD}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°MINER_PORT_LOW°/${MINER_PORT_LOW}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°MINER_PORT_MED°/${MINER_PORT_MED}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°MINER_PORT_HIG°/${MINER_PORT_HIG}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°POOL_API_PORT°/${POOL_API_PORT}/g" /usr/local/etc/haproxy/haproxy.cfg

service cron start
exec /docker-entrypoint.sh "$@"