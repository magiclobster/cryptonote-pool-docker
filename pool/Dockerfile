FROM debian:jessie
LABEL maintainer="magiclobster@mailbox.org"

ENV GIT_REPO https://github.com/billaue2/cryptonote-aeon-pool.git
ENV NODE_URL https://deb.nodesource.com/setup_8.x

RUN apt-get update && apt-get install -y \
	libboost-all-dev \
	git-core \
    curl \
	build-essential \
	libssl-dev \
	nginx

RUN curl -sL ${NODE_URL} | bash - \
    && apt-get install -y nodejs

WORKDIR /pool
RUN git clone ${GIT_REPO} /pool \
    && npm update

RUN rm -rf /etc/nginx/conf.d/* && rm /etc/nginx/sites-enabled/default

COPY pool.conf /etc/nginx/conf.d/
COPY config.json /pool/
COPY config.js /pool/website/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
