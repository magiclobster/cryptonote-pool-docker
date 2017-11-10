FROM debian:stretch
LABEL maintainer="magiclobster@mailbox.org"

RUN apt-get update && apt-get install -y \
	git-core \
	build-essential \
	cmake \
	libboost-all-dev \
	libssl-dev \
	pkg-config \
	libzmq3-dev \
	libunbound-dev \
	libminiupnpc-dev \
	libunwind8-dev \
	liblzma-dev \
	libreadline6-dev \
	libldns-dev \
	libexpat1-dev \
	libgtest-dev \
	doxygen \
	graphviz

ARG GIT_REPO
ARG GIT_TAG

RUN cd /usr/src/gtest && cmake . && make && mv libg* /usr/lib/ \
	&& mkdir /build && git clone ${GIT_REPO} /build && cd /build \
	&& git checkout ${GIT_TAG} && make

FROM debian:stretch
RUN mkdir -p /wallet/data
COPY --from=0 /build/build/release/bin/ /usr/local/bin/
COPY --from=0 /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/
RUN apt-get update && apt-get --no-install-recommends -y install curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY wallet.sh /usr/local/bin/wallet
COPY get_seed.sh /usr/local/bin/get_seed
COPY docker-entrypoint.sh /

WORKDIR /wallet
ENTRYPOINT ["/docker-entrypoint.sh"]
