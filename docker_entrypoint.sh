#!/bin/sh

set -ea

#export HOST_IP=$(ip -4 route list match 0/0 | awk '{print $3}')
#export WHO_AM_I=$(whoami)

echo "LNBITS_HOST = $LNBITS_HOST:$LNBITS_PORT"
touch /var/log/lnbits.log
#exec tini lnbits-lite
#exec uvicorn lnbits.__main__:app --port $LNBITS_PORT --host $LNBITS_HOST

/lnbits/venv/bin/create_lnbits_envs

exec tail -f /var/log/lnbits.log