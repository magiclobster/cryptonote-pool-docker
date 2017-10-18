FROM haproxy
LABEL maintainer="magiclobster@mailbox.org"

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && apt-get update && apt-get -y install -t jessie-backports \
    certbot \
    cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /cert_scripts/ /etc/letsencrypt/haproxy
COPY cert_scripts/* cert_scripts/
RUN ln -s /cert_scripts/create_ss.sh /usr/local/bin/create_ss \
    && ln -s /cert_scripts/get_le.sh /usr/local/bin/get_le
COPY haproxy.cfg /usr/local/etc/haproxy/
COPY docker-entrypoint.sh /change-docker-entrypoint.sh

WORKDIR /usr/local/etc/haproxy
ENTRYPOINT ["/change-docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]