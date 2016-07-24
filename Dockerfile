FROM debian:jessie

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

ENV S6_OVERLAY_VERSION=v1.18.1.3

RUN apt-get update \
    && apt-get install -y \
       gnupg \
       ca-certificates \
       net-tools \
       bash \
       curl \
       wget \
       unzip \
       nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gpg --keyserver pgp.mit.edu --recv-key 0x337EE704693C17EF \
    && wget https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz --no-check-certificate -O /tmp/s6-overlay-amd64.tar.gz \
    && wget https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz.sig --no-check-certificate -O /tmp/s6-overlay-amd64.tar.gz.sig \
    && gpg --verify /tmp/s6-overlay-amd64.tar.gz.sig /tmp/s6-overlay-amd64.tar.gz \
    && tar xvfz /tmp/s6-overlay-amd64.tar.gz -C / \
    && rm -f /tmp/s6-overlay-amd64.tar.gz \
    && rm -f /tmp/s6-overlay-amd64.tar.gz.sig

ADD rootfs /

ENTRYPOINT ["/init"]
