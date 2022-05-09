#!/bin/sh

export PATH=/home/lnbits/.local/bin/:$PATH

cd /home/lnbits/app/5000

export ENV QUART_APP="lnbits.app:create_app()"
export ENV QUART_ENV="development"
export ENV QUART_DEBUG="true"

quart assets
quart migrate

hypercorn -k trio --bind 0.0.0.0:5000 'lnbits.app:create_app()' --error-logfile /var/log/lnbits.log --access-logfile /var/log/lnbits-access.log --pid /tmp/hypercorn-5000.pid &

exec tail -f /var/log/lnbits.log