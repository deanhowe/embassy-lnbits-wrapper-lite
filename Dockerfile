ARG VERSION=0.8.0

FROM python:3.9-slim-buster as builder

ARG VERSION

WORKDIR /lnbits

RUN apt-get update \
&&  apt-get install -y build-essential pkg-config build-essential pkg-config wget

RUN  wget -c https://github.com/lnbits/lnbits-legend/archive/refs/tags/$VERSION.tar.gz -O - | tar -xz --strip-components=1

RUN python3 -m venv venv \
&&  ./venv/bin/pip install --upgrade pip \
&&  ./venv/bin/pip install wheel setuptools

RUN  ./venv/bin/pip install -r requirements.txt
RUN  ./venv/bin/pip install purerpc lndgrpc
RUN  ./venv/bin/pip install pylightning

# INSTALL JQ - for editing JSON
FROM python:3.9-slim-buster as lnbits

RUN apt-get update \
&&  apt-get install -y jq wget

# INSTALL YQ - for editing YAML
RUN wget -O /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.6.3/yq_linux_arm \
    && chmod a+x /usr/local/bin/yq

RUN apt-get update \
&&  apt-get install -y nano screen

COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh

COPY --from=builder /lnbits /lnbits

WORKDIR /lnbits

COPY create_lnbits_envs.sh ./venv/bin/create_lnbits_envs
RUN chmod +x ./venv/bin/create_lnbits_envs

COPY create_lnbits_instance.sh ./venv/bin/create_lnbits_instance
RUN chmod +x ./venv/bin/create_lnbits_instance

# Run as non-root
#USER lnbits:lnbits

#RUN addgroup -S lnbits && adduser -S lnbits -G lnbits


EXPOSE 5000 5001 5002 5003 5004 5005 8080

ENTRYPOINT ["/docker_entrypoint.sh"]
