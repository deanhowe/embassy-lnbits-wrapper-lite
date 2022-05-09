#!/bin/bash

# Load the env/config values from EmbassyOS

NUM_ACCOUNTS=$(yq e ".instances | length" /datadir/start9/config.yaml)

for i in $(seq 0 $(($NUM_ACCOUNTS-1)))
do

mkdir -p /home/lnbits/app/500$i

rm -f /home/lnbits/app/500$i/.env

TYPE=$(yq e ".instances[$i].connection-settings.type" /datadir/start9/config.yaml)

LNBITS_ALLOWED_USERS=$(yq e ".instances[$i].lnbits-allowed-users" /datadir/start9/config.yaml )
if [ "$LNBITS_ALLOWED_USERS" = "~" ]; then
        LNBITS_ALLOWED_USERS=""
fi

LND_REST_ENDPOINT_INPUT=$(yq e ".instances[$i].connection-settings.addressext" /datadir/start9/config.yaml ):$(yq e ".instances[$i].connection-settings.port" /datadir/start9/config.yaml )
LND_REST_CER_INPUTT=$(yq e ".instances[$i].connection-settings.certificate" /datadir/start9/config.yaml )
LND_REST_MACAROON_INPUT=$(yq e ".instances[$i].connection-settings.macaroon" /datadir/start9/config.yaml )

echo "
QUART_APP=$(yq e ".instances[$i].lnbits-quart.lnbits-quart-app" /datadir/start9/config.yaml )
QUART_ENV=$(yq e ".instances[$i].lnbits-quart.lnbits-quart-env" /datadir/start9/config.yaml )
QUART_DEBUG=$(yq e ".instances[$i].lnbits-quart.lnbits-quart-debug" /datadir/start9/config.yaml )

HOST=0.0.0.0
PORT=500$i

LNBITS_ALLOWED_USERS=\"$LNBITS_ALLOWED_USERS\"
LNBITS_DEFAULT_WALLET_NAME=\"$(yq e ".instances[$i].lnbits-site-meta.default-wallet-name" /datadir/start9/config.yaml )\"

LNBITS_DATA_FOLDER=\"/datadir/lnbits/500$i/data\"

# LNBITS_DATABASE_URL="postgres://user:password@host:port/databasename"

LNBITS_AD_SPACE="" # csv ad image filepaths or urls, extensions can choose to honor
LNBITS_HIDE_API=false # Hides wallet api, extensions can choose to honor

LNBITS_DISABLED_EXTENSIONS=\"$(yq e ".instances[$i].lnbits-quart.lnbits-disabled-extentions" /datadir/start9/config.yaml )\"
LNBITS_FORCE_HTTPS=$(yq e ".instances[$i].lnbits-quart.lnbits-force-https" /datadir/start9/config.yaml )
LNBITS_SERVICE_FEE=\"$(yq e ".instances[$i].lnbits-service-fee" /datadir/start9/config.yaml )\"

LNBITS_SITE_TITLE=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-site-title" /datadir/start9/config.yaml )\"
LNBITS_SITE_TAGLINE=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-site-tagline" /datadir/start9/config.yaml )\"
LNBITS_SITE_DESCRIPTION=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-site-description" /datadir/start9/config.yaml )\"
LNBITS_THEME_OPTIONS=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-theme-option" /datadir/start9/config.yaml )\"
" > /home/lnbits/app/500$i/.env

if [[ "$TYPE" == "CLightningWallet" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=CLightningWallet

CLIGHTNING_RPC=\"/mnt/c-lightning/lightning-rpc\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndWalletInternal" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LndWallet

LND_GRPC_ENDPOINT=$(yq e ".instances[$i].connection-settings.address" /datadir/start9/config.yaml )
LND_GRPC_PORT=11009
LND_GRPC_CERT=\"/mnt/lnd/tls.cert\"
LND_GRPC_MACAROON=\"/home/lnbits/app/admin.macaroon\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndWalletBROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOKEN" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LndWallet

LND_GRPC_ENDPOINT=$(yq e ".instances[$i].connection-settings.addressext" /datadir/start9/config.yaml )
LND_GRPC_PORT=$(yq e ".instances[$i].connection-settings.port" /datadir/start9/config.yaml )
LND_GRPC_CERT=\"$(yq e ".instances[$i].connection-settings.certificate" /datadir/start9/config.yaml )\"
LND_GRPC_MACAROON=\"$(yq e ".instances[$i].connection-settings.macaroon" /datadir/start9/config.yaml )\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndRest" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LndRestWallet

LND_REST_ENDPOINT=\"https://$(yq e ".instances[$i].connection-settings.address" /datadir/start9/config.yaml ):8080\"
LND_REST_CERT=\"/mnt/lnd/tls.cert\"
LND_REST_MACAROON=\"$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs)\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndRestWalletInternal" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LndRestWallet

LND_REST_ENDPOINT=\"https://$(yq e ".instances[$i].connection-settings.address" /datadir/start9/config.yaml ):8080\"
LND_REST_CERT=\"/datadir/lnbits/500$1/lnd/tls.cert\"
LND_REST_MACAROON=\"$(xxd -p -c 1000 /datadir/lnbits/500$1/lnd/tls.cert/admin.macaroon | xargs)\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndRestWalletBROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOKEN" ]]
then
        echo $LND_REST_MACAROON_INPUT >> /home/lnbits/app/500$i/admin.macaroon
        echo $LND_REST_CERT_INPUT >> /home/lnbits/app/500$i/cert
        # $(xxd -p -c 1000 /home/lnbits/app/500$i/admin.macaroon | xargs)
        echo "
LNBITS_BACKEND_WALLET_CLASS=LndRestWallet

LND_REST_ENDPOINT=\"https://$LND_REST_ENDPOINT\"
LND_REST_CERT=\"/home/lnbits/app/500$i/admin.macaroon\"
LND_REST_MACAROON=\"/home/lnbits/app/500$i/cert\"
# LND_REST_MACAROON_ENCRYPTED=\"eNcRyPtEdMaCaRoOn\" 
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "SparkWallet" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=SparkWallet

SPARK_URL=$(yq e ".instances[$i].connection-settings.lnbits-spark-url-with-port" /datadir/start9/config.yaml )
SPARK_TOKEN=$(yq e ".instances[$i].connection-settings.lnbits-spark-token" /datadir/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LNbitsWallet" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LNbitsWallet

LNBITS_ENDPOINT=$(yq e ".instances[$i].connection-settings.lnbits-lnbits-api-endpoint" /datadir/start9/config.yaml )
LNBITS_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lnbits-api-admin-key" /datadir/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LNPayWallet" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LNPayWallet

LNPAY_API_ENDPOINT=$(yq e ".instances[$i].connection-settings.lnbits-lnpay-api-endpoint" /datadir/start9/config.yaml )
LNPAY_API_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lnpay-api-key" /datadir/start9/config.yaml )
LNPAY_WALLET_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lnpay-wallet-key" /datadir/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LntxbotWallet" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=LntxbotWallet

LNTXBOT_API_ENDPOINT=$(yq e ".instances[$i].connection-settings.lnbits-lntxbot-api-endpoint" /datadir/start9/config.yaml )
LNTXBOT_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lntxbot-api-key" /datadir/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "OpenNodeWallet" ]]
then
        echo "
LNBITS_BACKEND_WALLET_CLASS=OpenNodeWallet

OPENNODE_API_ENDPOINT=$(yq e ".instances[$1].connection-settings.lnbits-opennode-api-endpoint" /datadir/start9/config.yaml )
OPENNODE_KEY=$(yq e ".instances[$1].connection-settings.lnbits-opennode-api-key" /datadir/start9/config.yaml )

# FakeWallet
FAKE_WALLET_SECRET=\"$(yq e ".instances[$1].connection-settings.lnbits-fakewallet-secret-key" /datadir/start9/config.yaml )\"

LNBITS_DENOMINATION=sats

" >> /home/lnbits/app/500$i/.env
fi
done