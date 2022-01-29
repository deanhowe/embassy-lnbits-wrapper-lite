#!/bin/sh

export WHO_AM_I=$(whoami)

#echo "Currently running in Docker as $WHO_AM_I"

export PATH=/home/lnbits/.local/bin/:$PATH

export EMBASSY_ENV_FILE='/home/lnbits/app/lnbits/.env.embassy'
export ENV_FILE='/home/lnbits/app/lnbits/lnbits-legend/.env'
export ENV_FILE_TMP='/home/lnbits/app/lnbits/lnbits-legend/.env.tmp'

##CONNECTION_TYPE=$(yq e ".connection-settings.type" /relay/start9/config.yaml)
##echo "Connection type = $CONNECTION_TYPE"
##
### Which back-end are we using?
### TAKE NOTE - WE ONLY COPY FROM THE .env.embassy ONCE - the other GREPin is on the actual .env
##export EMBASSY_LNBITS_BACKEND_WALLET_CLASS=$(yq e ".lnbits-backend-wallet-class" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_BACKEND_WALLET_CLASS@$EMBASSY_LNBITS_BACKEND_WALLET_CLASS@" $EMBASSY_ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_BACKEND_WALLET_CLASS
##
##export EMBASSY_QUART_APP=$(yq e ".lnbits-quart.lnbits-quart-app" /relay/start9/config.yaml )
##sed "s@EMBASSY_QUART_APP@$EMBASSY_QUART_APP@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_QUART_APP
##
##export EMBASSY_QUART_ENV=$(yq e ".instances[0].lnbits-quart.lnbits-quart-env" /relay/start9/config.yaml )
##sed "s@EMBASSY_QUART_ENV@$EMBASSY_QUART_ENV@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_QUART_ENV
##
##export EMBASSY_QUART_DEBUG=$(yq e ".instances[0].lnbits-quart.lnbits-quart-debug" /relay/start9/config.yaml )
##sed "s@EMBASSY_QUART_DEBUG@$EMBASSY_QUART_DEBUG@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_QUART_DEBUG
##
##export EMBASSY_LNBITS_FORCE_HTTPS=$(yq e ".instances[0].lnbits-quart.lnbits-force-https" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_FORCE_HTTPS@$EMBASSY_LNBITS_FORCE_HTTPS@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
##echo "Force https : $EMBASSY_LNBITS_FORCE_HTTPS"
##
##export EMBASSY_LNBITS_DISABLED_EXTENSIONS=$(yq e ".instances[0].lnbits-quart.lnbits-disabled-extentions" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_DISABLED_EXTENSIONS@$EMBASSY_LNBITS_DISABLED_EXTENSIONS@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo "Disabled Extentions : $EMBASSY_LNBITS_DISABLED_EXTENSIONS"
##
##export EMBASSY_LNBITS_ALLOWED_USERS=$(yq e ".instances[0].lnbits-allowed-users" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_ALLOWED_USERS@\"$EMBASSY_LNBITS_ALLOWED_USERS\"@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_ALLOWED_USERS
##
##sed "s@LNBITS_ALLOWED_USERS=\"~\"@LNBITS_ALLOWED_USERS=\"\"@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
##
##export EMBASSY_LNBITS_SITE_TITLE=$(yq e ".instances[0].lnbits-site-meta.lnbits-site-title" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_SITE_TITLE@$EMBASSY_LNBITS_SITE_TITLE@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_SITE_TITLE
##
##export EMBASSY_LNBITS_SITE_TAGLINE=$(yq e ".instances[0].lnbits-site-meta.lnbits-site-tagline" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_SITE_TAGLINE@$EMBASSY_LNBITS_SITE_TAGLINE@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_SITE_TAGLINE
##
##export EMBASSY_LNBITS_SITE_DESCRIPTION=$(yq e ".instances[0].lnbits-site-meta.lnbits-site-description" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_SITE_DESCRIPTION@$EMBASSY_LNBITS_SITE_DESCRIPTION@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_SITE_DESCRIPTION
##
##export EMBASSY_LNBITS_DEFAULT_WALLET_NAME=$(yq e ".instances[0].lnbits-site-meta.default-wallet-name" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_DEFAULT_WALLET_NAME@$EMBASSY_LNBITS_DEFAULT_WALLET_NAME@g" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_DEFAULT_WALLET_NAME
##
##export EMBASSY_LNBITS_THEME_OPTIONS=$(yq e ".instances[0].lnbits-site-meta.lnbits-theme-option" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_THEME_OPTIONS@$EMBASSY_LNBITS_THEME_OPTIONS@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_THEME_OPTIONS
##
##export EMBASSY_LNBITS_SERVICE_FEE=$(yq e ".instances[0].lnbits-service-fee" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_SERVICE_FEE@$EMBASSY_LNBITS_SERVICE_FEE@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo "Service Fee :$EMBASSY_LNBITS_SERVICE_FEE"
##
##export EMBASSY_LNBITS_LNPAY_API_ENDPOINT=$(yq e ".instances[0].connection-settings[0].lnbits-lnpay-api-endpoint" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_LNPAY_API_ENDPOINT@$EMBASSY_LNBITS_LNPAY_API_ENDPOINT@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_LNPAY_API_ENDPOINT
##
##export EMBASSY_LNBITS_LNPAY_API_KEY=$(yq e ".instances[0].connection-settings[0].lnbits-lnpay-api-key" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_LNPAY_API_KEY@$EMBASSY_LNBITS_LNPAY_API_KEY@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_LNPAY_API_KEY
##
##export EMBASSY_LNBITS_LNPAY_ADMIN_KEY=$(yq e ".instances[0].connection-settings[0].lnbits-lnpay-wallet-key" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_LNPAY_ADMIN_KEY@$EMBASSY_LNBITS_LNPAY_ADMIN_KEY@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_LNPAY_ADMIN_KEY
##
##export EMBASSY_LNBITS_LND_HOST=$(yq e ".instances[0].connection-settings.address" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_LND_HOST@$EMBASSY_LNBITS_LND_HOST@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LNBITS_LND_HOST
##
##export EMBASSY_LND_REST_MACAROON=$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs)
##sed "s@EMBASSY_LND_REST_MACAROON@$EMBASSY_LND_REST_MACAROON@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LND_REST_MACAROON
##
##export EMBASSY_LNBITS_LND_GRPC_ENDPOINT=$(yq e ".instances[0].connection-settings.address" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_LND_GRPC_ENDPOINT@$EMBASSY_LNBITS_LND_GRPC_ENDPOINT@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
##
##export EMBASSY_LND_GRPC_MACAROON=$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs)
##sed "s@EMBASSY_LND_GRPC_MACAROON@$EMBASSY_LND_GRPC_MACAROON@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_LND_REST_MACAROON
##
##export EMBASSY_SPARK_URL=$(yq e ".instances[0].connection-settings.lnbits-spark-url" /relay/start9/config.yaml )
##sed "s@EMBASSY_SPARK_URL@$EMBASSY_SPARK_URL@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo $EMBASSY_SPARK_URL
##
##export EMBASSY_ACCOUNT_SPARK_URL=$(yq e ".instances[0].connection-settings.lnbits-spark-url" /relay/start9/config.yaml )
###echo "EMBASSY_ACCOUNT_SPARK_URL = $EMBASSY_ACCOUNT_SPARK_URL"
##
##export EMBASSY_SPARK_TOKEN=$(yq e ".instances[0].connection-settings.lnbits-spark-token" /relay/start9/config.yaml )
##sed "s@EMBASSY_SPARK_TOKEN@$EMBASSY_SPARK_TOKEN@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo "EMBASSY_SPARK_TOKEN = $EMBASSY_SPARK_TOKEN"
##
##export EMBASSY_LNBITS_API_ENDPOINT=$(yq e ".instances[0].connection-settings.lnbits-lnbits-api-endpoint" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_API_ENDPOINT@$EMBASSY_LNBITS_API_ENDPOINT@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo "EMBASSY_LNBITS_API_ENDPOINT = $EMBASSY_LNBITS_API_ENDPOINT"
##
##export EMBASSY_LNBITS_ADMIN_KEY=$(yq e ".instances[0].connection-settings.lnbits-lnbits-api-admin-key" /relay/start9/config.yaml )
##sed "s@EMBASSY_LNBITS_ADMIN_KEY@$EMBASSY_LNBITS_ADMIN_KEY@" $ENV_FILE > $ENV_FILE_TMP && mv $ENV_FILE_TMP $ENV_FILE
###echo "EMBASSY_LNBITS_ADMIN_KEY = $EMBASSY_LNBITS_ADMIN_KEY"


#exec pwd
/home/lnbits/.local/echo_lnbits_envs

cd /home/lnbits/app/5000

#echo $QUART_APP

#mkdir -p /home/lnbits/app/lnbits/lnbits-legend/data

export ENV QUART_APP="lnbits.app:create_app()"
export ENV QUART_ENV="development"
export ENV QUART_DEBUG="true"

quart assets
quart migrate

hypercorn -k trio --bind 0.0.0.0:5000 'lnbits.app:create_app()' --error-logfile /var/log/lnbits.log --access-logfile /var/log/lnbits-access.log --pid /tmp/hypercorn-5000.pid &

exec tail -f /var/log/lnbits.log