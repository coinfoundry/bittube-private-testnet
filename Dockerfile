FROM ubuntu:bionic
MAINTAINER sh@analogic.cz

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz \
    https://github.com/ipbc-dev/bittube/releases/download/2.0.0.4/bittube-linux-x64-v2.0.0.4.zip \
    /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    apt-get update && apt-get install -y --no-install-recommends unzip libpcsclite1 libc6 && \
    cd /tmp && unzip bittube*.zip && cp -R bittube* /usr/bin && chmod +x /usr/bin/bittube* && \
    apt-get remove -y unzip && \
    rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* /var/cache/man/* /tmp/* /var/lib/apt/lists/*

EXPOSE 29080 39080 29081 39081 29082 39082

ENTRYPOINT ["/init"]
VOLUME ["/data"]
ADD rootfs /
