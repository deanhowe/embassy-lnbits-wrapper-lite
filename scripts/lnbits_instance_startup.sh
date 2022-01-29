#!/bin/sh

export WHO_AM_I=$(whoami)

#echo "Currently running in Docker as $WHO_AM_I"

#export PATH=/home/lnbits/.local/bin:$PATH

cd /home/lnbits/app/500$1

#echo $QUART_APP

#mkdir -p /home/lnbits/app/lnbits/lnbits-legend/data

export EMBASSY_LNBITS_BACKEND_WALLET_CLASS=$(yq e ".instances[$1].connection-settings.type" /relay/start9/config.yaml)

#if [ "$EMBASSY_LNBITS_BACKEND_WALLET_CLASS" = "CLightningWallet" ]; then
#    echo "Installing the C-Lightning Python libraries…"
#    pip3 install pylightning
#    echo "Installed… pylightning at boot up time"
#elif [ "$EMBASSY_LNBITS_BACKEND_WALLET_CLASS" = "LndWallet" ] || [ "$EMBASSY_LNBITS_BACKEND_WALLET_CLASS" = "LndWalletInternal" ]; then
#    echo "Installing the LND Python libraries…"
#	pip3 install lndgrpc purerpc
#    echo "Installed… lndgrpc purerpc at boot up time"
#fi

export QUART_APP=$(yq e ".instances[$1].lnbits-quart.lnbits-quart-app" /relay/start9/config.yaml )
export QUART_ENV=$(yq e ".instances[$1].lnbits-quart.lnbits-quart-env" /relay/start9/config.yaml )
export QUART_DEBUG=$(yq e ".instances[$1].lnbits-quart.lnbits-quart-debug" /relay/start9/config.yaml )

echo $EMBASSY_LNBITS_BACKEND_WALLET_CLASS

quart assets
quart migrate

hypercorn -k trio --bind 0.0.0.0:500$1 $QUART_APP --error-logfile /var/log/lnbits-500$1.log --access-logfile /var/log/lnbits-access-500$1.log --pid /tmp/hypercorn-500$1.pid &

#exec tail -f /var/log/lnbits.log
#export QUART_APP=$(yq e ".instances[1].lnbits-quart.lnbits-quart-app" /relay/start9/config.yaml )
#export QUART_ENV=$(yq e ".instances[1].lnbits-quart.lnbits-quart-env" /relay/start9/config.yaml )
#export QUART_DEBUG=$(yq e ".instances[1].lnbits-quart.lnbits-quart-debug" /relay/start9/config.yaml )

#QUART_APP=$(yq e ".instances[1].lnbits-quart.lnbits-quart-app" /relay/start9/config.yaml )
#QUART_ENV=$(yq e ".instances[1].lnbits-quart.lnbits-quart-env" /relay/start9/config.yaml )
#QUART_DEBUG=$(yq e ".instances[1].lnbits-quart.lnbits-quart-debug" /relay/start9/config.yaml )
