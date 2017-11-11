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

RUN mkdir /build && git clone ${GIT_REPO} /build && cd build \
        git checkout -b ${GIT_TAG} && mkdir -p build/release && cd build/release && cmake -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=release ../.. && make

FROM debian:stretch-slim
COPY --from=0 /build/build/release/src/aeond /usr/local/bin/
COPY --from=0 /build/build/release/src/simplewallet /usr/local/bin/
COPY --from=0 /build/build/release/src/simpleminer /usr/local/bin/
RUN apt-get update && apt-get --no-install-recommends -y install curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /wallet/data
COPY wallet.sh /usr/local/bin/wallet
COPY get_seed.sh /usr/local/bin/get_seed
COPY docker-entrypoint.sh /
WORKDIR /wallet
ENTRYPOINT ["/docker-entrypoint.sh"]
