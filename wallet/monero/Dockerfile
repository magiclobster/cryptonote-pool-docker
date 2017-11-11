FROM ubuntu:16.04
LABEL maintainer="magiclobster@mailbox.org"

RUN apt-get update && apt-get install -y \
	ca-certificates \
          cmake \
          g++ \
          git \
          libboost1.58-all-dev \
          libssl-dev \
          libzmq3-dev \
          libsodium-dev \
          make \
          pkg-config

ARG GIT_REPO
ARG GIT_TAG

RUN mkdir /build && git clone ${GIT_REPO} /build && cd /build \
	&& git checkout -b ${GIT_TAG} \
	&& make release-static

FROM debian:stretch-slim
RUN mkdir -p /wallet/data
COPY --from=0 /build/build/release/bin/ /usr/local/bin/
RUN apt-get update && apt-get --no-install-recommends -y install curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY wallet.sh /usr/local/bin/wallet
COPY get_seed.sh /usr/local/bin/get_seed
COPY docker-entrypoint.sh /

WORKDIR /wallet
ENTRYPOINT ["/docker-entrypoint.sh"]
