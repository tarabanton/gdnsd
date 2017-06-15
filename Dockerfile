FROM debian:jessie-backports

ADD build/ /tmp

RUN apt-get update && \
    apt-get install -y libc6 libev4 liburcu2 libmaxminddb0 libunwind8 init-system-helpers && \
    apt-get install -y git openssh-client make && \
    dpkg -i tmp/gdnsd_2.2.4-1_amd64.deb && \
    apt-get autoremove && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 53 53/udp 3506
VOLUME ["/dns"]

CMD ["/usr/sbin/gdnsd", "-fx", "-c", "/dns", "start"]
