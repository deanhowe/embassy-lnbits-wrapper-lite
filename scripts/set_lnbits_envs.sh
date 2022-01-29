#!/bin/sh

export WHO_AM_I=$(whoami)
export PATH=/home/lnbits/.local/bin/:$PATH

export EMBASSY_ENV_FILE='/home/lnbits/app/lnbits/.env.embassy'
export ENV_FILE='/home/lnbits/app/lnbits/lnbits-legend/.env'
export ENV_FILE_TMP='/home/lnbits/app/lnbits/lnbits-legend/.env.tmp'

export EMBASSY_LNBITS_BACKEND_WALLET_CLASS=$(yq e ".lnbits-backend-wallet-class" /relay/start9/config.yaml )
export EMBASSY_QUART_APP=$(yq e ".lnbits-quart.lnbits-quart-app" /relay/start9/config.yaml )
export EMBASSY_QUART_ENV=$(yq e ".lnbits-quart.lnbits-quart-env" /relay/start9/config.yaml )
export EMBASSY_QUART_DEBUG=$(yq e ".lnbits-quart.lnbits-quart-debug" /relay/start9/config.yaml )

export EMBASSY_LNBITS_FORCE_HTTPS=$(yq e ".lnbits-quart.lnbits-force-https" /relay/start9/config.yaml )
export EMBASSY_LNBITS_DISABLED_EXTENSIONS=$(yq e ".lnbits-quart.lnbits-disabled-extentions" /relay/start9/config.yaml )
export EMBASSY_LNBITS_ALLOWED_USERS=$(yq e ".lnbits-allowed-users" /relay/start9/config.yaml )
export EMBASSY_LNBITS_SITE_TITLE=$(yq e ".lnbits-site-meta.lnbits-site-title" /relay/start9/config.yaml )
export EMBASSY_LNBITS_SITE_TAGLINE=$(yq e ".lnbits-site-meta.lnbits-site-tagline" /relay/start9/config.yaml )
export EMBASSY_LNBITS_SITE_DESCRIPTION=$(yq e ".lnbits-site-meta.lnbits-site-description" /relay/start9/config.yaml )
export EMBASSY_LNBITS_DEFAULT_WALLET_NAME=$(yq e ".lnbits-site-meta.default-wallet-name" /relay/start9/config.yaml )
export EMBASSY_LNBITS_THEME_OPTIONS=$(yq e ".lnbits-site-meta.lnbits-theme-option" /relay/start9/config.yaml )
export EMBASSY_LNBITS_SERVICE_FEE=$(yq e ".lnbits-service-fee" /relay/start9/config.yaml )
export EMBASSY_LNBITS_LNPAY_API_ENDPOINT=$(yq e ".accounts[0].connection-settings[0].lnbits-lnpay-api-endpoint" /relay/start9/config.yaml )
export EMBASSY_LNBITS_LNPAY_API_KEY=$(yq e ".accounts[0].connection-settings[0].lnbits-lnpay-api-key" /relay/start9/config.yaml )
export EMBASSY_LNBITS_LNPAY_ADMIN_KEY=$(yq e ".accounts[0].connection-settings[0].lnbits-lnpay-wallet-key" /relay/start9/config.yaml )
export EMBASSY_LNBITS_LND_HOST=$(yq e ".accounts[0].connection-settings.address" /relay/start9/config.yaml )
export EMBASSY_LND_REST_MACAROON=$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs)
export EMBASSY_LNBITS_LND_GRPC_ENDPOINT=$(yq e ".accounts[0].connection-settings.address" /relay/start9/config.yaml )
export EMBASSY_LND_GRPC_MACAROON=$(xxd -p -c 1000 /home/lnbits/app/admin.macaroon | xargs)
export EMBASSY_SPARK_URL=$(yq e ".accounts[0].connection-settings.lnbits-spark-url" /relay/start9/config.yaml )
export EMBASSY_ACCOUNT_SPARK_URL=$(yq e ".accounts[0].connection-settings.lnbits-spark-url" /relay/start9/config.yaml )
export EMBASSY_SPARK_TOKEN=$(yq e ".accounts[0].connection-settings.lnbits-spark-token" /relay/start9/config.yaml )
export EMBASSY_LNBITS_API_ENDPOINT=$(yq e ".accounts[0].connection-settings.lnbits-lnbits-api-endpoint" /relay/start9/config.yaml )
export EMBASSY_LNBITS_ADMIN_KEY=$(yq e ".accounts[0].connection-settings.lnbits-lnbits-api-admin-key" /relay/start9/config.yaml )

export ENV QUART_APP="lnbits.app:create_app()"
export ENV QUART_ENV="development"
export ENV QUART_DEBUG="true"