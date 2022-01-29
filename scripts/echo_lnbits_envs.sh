#!/bin/sh

# Load the env/config values from EmbassyOS
##. /home/lnbits/.local/set_lnbits_envs

#for i in $(seq 0 $(($NUM_ACCOUNTS-1)))
#for i in $(seq 0 $(($NUM_ACCOUNTS-1)))

# Print out all the env/config values from Embassy OS
##echo "EMBASSY_LNBITS_BACKEND_WALLET_CLASS = $EMBASSY_LNBITS_BACKEND_WALLET_CLASS"
##echo "EMBASSY_QUART_APP = $EMBASSY_QUART_APP"
##echo "EMBASSY_QUART_ENV = $EMBASSY_QUART_ENV"
##echo "EMBASSY_QUART_DEBUG = $EMBASSY_QUART_DEBUG"
##
##echo "Force https : $EMBASSY_LNBITS_FORCE_HTTPS"
##echo "Disabled Extentions : $EMBASSY_LNBITS_DISABLED_EXTENSIONS"
##
##echo "EMBASSY_LNBITS_ALLOWED_USERS = $EMBASSY_LNBITS_ALLOWED_USERS"
##
##echo "EMBASSY_LNBITS_SITE_TITLE = $EMBASSY_LNBITS_SITE_TITLE"
##echo "EMBASSY_LNBITS_SITE_TAGLINE = $EMBASSY_LNBITS_SITE_TAGLINE"
##echo "EMBASSY_LNBITS_SITE_DESCRIPTION = $EMBASSY_LNBITS_SITE_DESCRIPTION"
##
##echo "EMBASSY_LNBITS_DEFAULT_WALLET_NAME = $EMBASSY_LNBITS_DEFAULT_WALLET_NAME"
##echo "EMBASSY_LNBITS_THEME_OPTIONS = $EMBASSY_LNBITS_THEME_OPTIONS"
##
##echo "Service Fee :$EMBASSY_LNBITS_SERVICE_FEE"
##
##echo "EMBASSY_LNBITS_LNPAY_API_ENDPOINT = $EMBASSY_LNBITS_LNPAY_API_ENDPOINT"
##echo "EMBASSY_LNBITS_LNPAY_API_KEY = $EMBASSY_LNBITS_LNPAY_API_KEY"
##echo "EMBASSY_LNBITS_LNPAY_ADMIN_KEY = $EMBASSY_LNBITS_LNPAY_ADMIN_KEY"
##
##echo "EMBASSY_LNBITS_LND_HOST = $EMBASSY_LNBITS_LND_HOST"
##
##echo "EMBASSY_LND_REST_MACAROON = $EMBASSY_LND_REST_MACAROON"
##echo "EMBASSY_LND_REST_MACAROON = $EMBASSY_LND_REST_MACAROON"
##
##echo "EMBASSY_SPARK_URL = $EMBASSY_SPARK_URL"
##
##echo "EMBASSY_ACCOUNT_SPARK_URL = $EMBASSY_ACCOUNT_SPARK_URL"
##echo "EMBASSY_ACCOUNT_SPARK_URL = $EMBASSY_ACCOUNT_SPARK_URL"
##echo "EMBASSY_SPARK_TOKEN = $EMBASSY_SPARK_TOKEN"
##
##echo "EMBASSY_LNBITS_API_ENDPOINT = $EMBASSY_LNBITS_API_ENDPOINT"
##echo "EMBASSY_LNBITS_ADMIN_KEY = $EMBASSY_LNBITS_ADMIN_KEY"

NUM_ACCOUNTS=$(yq e ".instances | length" /relay/start9/config.yaml)

for i in $(seq 0 $(($NUM_ACCOUNTS-1)))
do

TYPE=$(yq e ".instances[$i].connection-settings.type" /relay/start9/config.yaml)

LNBITS_ALLOWED_USERS=$(yq e ".instances[$i].lnbits-allowed-users" /relay/start9/config.yaml )
if [ "$LNBITS_ALLOWED_USERS" = "~" ]; then
	LNBITS_ALLOWED_USERS=""
fi

LND_REST_ENDPOINT=$(yq e ".instances[$i].connection-settings.addressext" /relay/start9/config.yaml ):$(yq e ".instances[$i].connection-settings.port" /relay/start9/config.yaml )
LND_REST_CERT=$(yq e ".instances[$i].connection-settings.certificate" /relay/start9/config.yaml )
LND_REST_MACAROON=$(yq e ".instances[$i].connection-settings.macaroon" /relay/start9/config.yaml )

echo "
QUART_APP=$(yq e ".instances[$i].lnbits-quart.lnbits-quart-app" /relay/start9/config.yaml )
QUART_ENV=$(yq e ".instances[$i].lnbits-quart.lnbits-quart-env" /relay/start9/config.yaml )
QUART_DEBUG=$(yq e ".instances[$i].lnbits-quart.lnbits-quart-debug" /relay/start9/config.yaml )

HOST=0.0.0.0
PORT=500$i

LNBITS_ALLOWED_USERS=\"$LNBITS_ALLOWED_USERS\"
LNBITS_DEFAULT_WALLET_NAME=\"$(yq e ".instances[$i].lnbits-site-meta.default-wallet-name" /relay/start9/config.yaml )\"

LNBITS_DATA_FOLDER=\"/relay/lnbits/lnbits-legend/500$i/data\"

# LNBITS_DATABASE_URL="postgres://user:password@host:port/databasename"

LNBITS_DISABLED_EXTENSIONS=\"$(yq e ".instances[$i].lnbits-quart.lnbits-disabled-extentions" /relay/start9/config.yaml )\"
LNBITS_FORCE_HTTPS=$(yq e ".instances[$i].lnbits-quart.lnbits-force-https" /relay/start9/config.yaml )
LNBITS_SERVICE_FEE=\"$(yq e ".instances[$i].lnbits-service-fee" /relay/start9/config.yaml )\"

LNBITS_SITE_TITLE=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-site-title" /relay/start9/config.yaml )\"
LNBITS_SITE_TAGLINE=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-site-tagline" /relay/start9/config.yaml )\"
LNBITS_SITE_DESCRIPTION=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-site-description" /relay/start9/config.yaml )\"
LNBITS_THEME_OPTIONS=\"$(yq e ".instances[$i].lnbits-site-meta.lnbits-theme-option" /relay/start9/config.yaml )\"
" > /home/lnbits/app/500$i/.env

if [[ "$TYPE" == "CLightningWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=CLightningWallet

CLIGHTNING_RPC=\"/relay/start9/shared/c-lightning/lightning-rpc\"	
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndWalletInternal" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LndWallet
	
LND_GRPC_ENDPOINT=$(yq e ".instances[$i].connection-settings.address" /relay/start9/config.yaml )
LND_GRPC_PORT=11009
LND_GRPC_CERT=\"/relay/start9/public/lnd/tls.cert\"
LND_GRPC_MACAROON=\"$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs )\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LndWallet

LND_GRPC_ENDPOINT=$(yq e ".instances[$i].connection-settings.addressext" /relay/start9/config.yaml )
LND_GRPC_PORT=$(yq e ".instances[$i].connection-settings.port" /relay/start9/config.yaml )
LND_GRPC_CERT=\"$(yq e ".instances[$i].connection-settings.certificate" /relay/start9/config.yaml )\"
LND_GRPC_MACAROON=\"$(yq e ".instances[$i].connection-settings.macaroon" /relay/start9/config.yaml )\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndRestWalletInternal" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LndRestWallet

LND_REST_ENDPOINT=\"https://$(yq e ".instances[$i].connection-settings.address" /relay/start9/config.yaml ):8080\"
LND_REST_CERT=\"/relay/start9/public/lnd/tls.cert\"
LND_REST_MACAROON=\"$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs)\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LndRestWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LndRestWallet

LND_REST_ENDPOINT=\"https://$LND_REST_ENDPOINT\"
LND_REST_CERT=\"$LND_REST_CERT\"
LND_REST_MACAROON=\"$LND_REST_MACAROON\"
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "SparkWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=SparkWallet

SPARK_URL=$(yq e ".instances[$i].connection-settings.lnbits-spark-url-with-port" /relay/start9/config.yaml )
SPARK_TOKEN=$(yq e ".instances[$i].connection-settings.lnbits-spark-token" /relay/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LNbitsWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LNbitsWallet

LNBITS_ENDPOINT=$(yq e ".instances[$i].connection-settings.lnbits-lnbits-api-endpoint" /relay/start9/config.yaml )
LNBITS_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lnbits-api-admin-key" /relay/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LNPayWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LNPayWallet

LNPAY_API_ENDPOINT=$(yq e ".instances[$i].connection-settings.lnbits-lnpay-api-endpoint" /relay/start9/config.yaml )
LNPAY_API_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lnpay-api-key" /relay/start9/config.yaml )
LNPAY_WALLET_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lnpay-wallet-key" /relay/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "LntxbotWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=LntxbotWallet

LNTXBOT_API_ENDPOINT=$(yq e ".instances[$i].connection-settings.lnbits-lntxbot-api-endpoint" /relay/start9/config.yaml )
LNTXBOT_KEY=$(yq e ".instances[$i].connection-settings.lnbits-lntxbot-api-key" /relay/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env

elif [[ "$TYPE" == "OpenNodeWallet" ]]
then
	echo "
LNBITS_BACKEND_WALLET_CLASS=OpenNodeWallet
	
OPENNODE_API_ENDPOINT=$(yq e ".instances[$1].connection-settings.lnbits-opennode-api-endpoint" /relay/start9/config.yaml )
OPENNODE_KEY=$(yq e ".instances[$1].connection-settings.lnbits-opennode-api-key" /relay/start9/config.yaml )
" >> /home/lnbits/app/500$i/.env
fi
done