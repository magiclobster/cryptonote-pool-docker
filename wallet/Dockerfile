FROM debian:stretch
LABEL maintainer="magiclobster@mailbox.org"

RUN apt-get update && apt-get install -y \
	git-core \
	build-essential \
	cmake \
	libboost-all-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

ARG GIT_REPO
ARG GIT_TAG
ARG WALLET_DAEMON_BIN
ARG WALLET_BIN

RUN mkdir -p /wallet/data && mkdir /build && git clone --branch ${GIT_TAG} ${GIT_REPO} /build \
	&& cd build && make \
	&& cp /build/build/release/src/${WALLET_BIN} /wallet/wallet && cp /build/build/release/src/${WALLET_DAEMON_BIN} /wallet/walletd \
	&& rm -rf /build

COPY docker-entrypoint.sh /
COPY wallet get_seed.sh /usr/local/bin/get_seed/
WORKDIR /wallet
ENTRYPOINT ["/docker-entrypoint.sh"]
