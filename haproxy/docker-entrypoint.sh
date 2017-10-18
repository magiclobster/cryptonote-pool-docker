#!/usr/bin/env bash

if [ ! -f /etc/letsencrypt/haproxy/${AEON_WEB_DOMAIN}.pem ]; then
    echo "ssl cert missing, creating self signed"
    create_ss ${AEON_WEB_DOMAIN}
fi

sed -i "s/°HAPROXY_STATS_PASSWORD°/${HAPROXY_STATS_PASSWORD}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_WEB_DOMAIN°/${AEON_WEB_DOMAIN}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_PORT_LOW°/${AEON_PORT_LOW}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_PORT_MED°/${AEON_PORT_MED}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_PORT_HIG°/${AEON_PORT_HIG}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_PORT_EXT°/${AEON_PORT_EXT}/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/°AEON_API_PORT°/${AEON_API_PORT}/g" /usr/local/etc/haproxy/haproxy.cfg

service cron start
exec /docker-entrypoint.sh "$@"