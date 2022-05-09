FROM arm64v8/alpine:3.14 as builder

#ENV FLASK_APP=app.py
#ENV FLASK_RUN_HOST=0.0.0.0
#ENV PATH="/home/lnbits/.local/bin:$PATH"

RUN apk update && apk add --no-cache python3 python3-dev gcc g++ openssl musl-dev linux-headers

WORKDIR /home/lnbits/app

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip

RUN addgroup -S lnbits && adduser -S lnbits -G lnbits

USER lnbits

COPY --chown=lnbits:lnbits ./lnbits-legend/requirements.txt requirements_all.txt
RUN pip3 install -r requirements_all.txt --no-warn-script-location

RUN pip3 install pylightning
#RUN pip3 install lndgrpc
#RUN pip3 install purerpc

#FROM alpine:3.12 as lnbits

#RUN apk update && apk add --no-cache python3

#RUN addgroup -S lnbits && adduser -S lnbits -G lnbits
#RUN addgroup lnbits root

WORKDIR /home/lnbits/app

#RUN python3 -m ensurepip && \
#    rm -r /usr/lib/python*/ensurepip

USER root

# INSTALL JQ - for editing JSON
RUN apk update && apk add jq

# INSTALL YQ - for editing YAML
RUN wget -O /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.6.3/yq_linux_arm \
    && chmod a+x /usr/local/bin/yq

# INSTALL NANO ~::~ AND TAKE THIS AS A REMINDER TO CLEAN UP THE BUILD AT THE END!!
# #
RUN apk update && apk add nano

RUN apk update && apk add sudo

RUN apk update && apk add libstdc++

#RUN apk update && apk add tini

# Add the ENTRYPOINT 
COPY --chown=lnbits:lnbits ./docker_entrypoint.sh /home/lnbits/.local/docker_entrypoint.sh
COPY --chown=lnbits:lnbits ./check_web.sh /check_web.sh
RUN chmod a+x /home/lnbits/.local/docker_entrypoint.sh

# Add the LNBits STARTUP script for the ENTRYPOINT 
COPY --chown=lnbits:lnbits ./scripts/lnbits_startup_script.sh /home/lnbits/.local/lnbits_startup_script.sh
RUN chmod a+x /home/lnbits/.local/lnbits_startup_script.sh

COPY --chown=lnbits:lnbits ./scripts/lnbits_instance_startup.sh /home/lnbits/.local/lnbits_instance_startup.sh
RUN chmod a+x /home/lnbits/.local/lnbits_instance_startup.sh

#COPY --chown=lnbits:lnbits ./blinkin.sh /home/lnbits/.local/blinkin
#RUN chmod a+x /home/lnbits/.local/blinkin

RUN touch /var/log/lnbits.log && chown lnbits:lnbits /var/log/lnbits.log
RUN touch /var/log/lnbits-access.log && chown lnbits:lnbits /var/log/lnbits-access.log
RUN touch /var/log/lnbits-error.log && chown lnbits:lnbits /var/log/lnbits-error.log

#RUN /relay/lnbits

#USER lnbits

USER root

#ENV FLASK_APP=app.py
#ENV FLASK_RUN_HOST=0.0.0.0
#ENV PATH="/home/lnbits/.local/bin:$PATH"

WORKDIR /home/lnbits/app
#COPY --from=builder --chown=lnbits:lnbits /home/lnbits/.local /home/lnbits/.local

EXPOSE 5005 5000 5001 5002 5003 5004 8080

COPY --chown=lnbits:lnbits ./lnbits-legend/lnbits ./lnbits/lnbits-legend
#COPY --chown=lnbits:lnbits ./.env.embassy ./lnbits/

COPY --chown=lnbits:lnbits ./scripts/lnbits_extra_actions.sh /home/lnbits/.local/lnbits_extra_actions
RUN chmod a+x /home/lnbits/.local/lnbits_extra_actions

COPY --chown=lnbits:lnbits ./scripts/set_lnbits_envs.sh /home/lnbits/.local/set_lnbits_envs
RUN chmod a+x /home/lnbits/.local/set_lnbits_envs

COPY --chown=lnbits:lnbits ./scripts/echo_lnbits_envs.sh /home/lnbits/.local/echo_lnbits_envs
RUN chmod a+x /home/lnbits/.local/echo_lnbits_envs

COPY --chown=lnbits:lnbits ./scripts/echo_lnbits_envs.sh /home/lnbits/.local/echo_new_lnbits_envs
RUN chmod a+x /home/lnbits/.local/echo_new_lnbits_envs

COPY --chown=lnbits:lnbits 


#cp -pr /datadir/lnbits/python_local/bin/protoc-gen-purerpc /home/lnbits/.local/bin/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/aiogrpc* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/anyio* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/google* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/grpc* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/purerpc* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/h2* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/hyperframe* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/lndgrpc* /home/lnbits/.local/lib/python3.9/site-packages/
#cp -pr /datadir/lnbits/python_local/lib/python3.9/site-packages/protobuf* /home/lnbits/.local/lib/python3.9/site-packages/



WORKDIR /home/lnbits/app/lnbits/lnbits-legend

ENTRYPOINT ["/home/lnbits/.local/docker_entrypoint.sh"]
