FROM arm64v8/alpine:3.12

RUN apk update
RUN apk add tini

#ADD ./lnbits-lite/target/aarch64-unknown-linux-musl/release/lnbits-lite /usr/local/bin/lnbits-lite
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh

WORKDIR /root

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
