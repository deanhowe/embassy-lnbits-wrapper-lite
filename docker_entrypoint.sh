#!/bin/sh

set -ea

export HOST_IP=$(ip -4 route list match 0/0 | awk '{print $3}')
export WHO_AM_I=$(whoami)

export PATH=/home/lnbits/.local/bin/:$PATH

export EMBASSY_LNBITS_BACKEND_WALLET_CLASS=$(yq e ".instances[0].connection-settings.type" /relay/start9/config.yaml)

if [ ! -f /home/lnbits/.profile ]; then
	echo "First Boot!"
	echo PATH=/home/lnbits/.local/bin/:$PATH > /home/lnbits/.profile
	chown lnbits:lnbits /home/lnbits/.profile
		
	for i in $(seq 0 5)
	do
		mkdir -p /relay/lnbits/lnbits-legend/500$i/data
		mkdir -p /home/lnbits/app/500$i/lnbits
		cp -pr /home/lnbits/app/lnbits/lnbits-legend/lnbits /home/lnbits/app/500$i/
	done
	
	chown -R lnbits:lnbits /home/lnbits/app
	
	if [ "$EMBASSY_LNBITS_BACKEND_WALLET_CLASS" = "CLightningWallet" ]; then
		echo "Installing the C-Lightning Python libraries…"
		su -s /bin/sh -c 'pip3 install pylightning' lnbits
		echo "Installed… pylightning at boot up time"
	elif [ "$EMBASSY_LNBITS_BACKEND_WALLET_CLASS" = "LndWallet" ]; then
		echo "Installing the LND Python libraries…"
		su -s /bin/sh -c 'pip3 install lndgrpc purerpc' lnbits
		echo "Installed… lndgrpc purerpc at boot up time"
	fi

	echo "Welcome to the LNBits community!"
fi



echo "$HOST_IP running as $WHO_AM_I"

echo "Checking if we have an SQLite3 DB…"

if [ ! -f /relay/lnbits/lnbits-legend/data/database.sqlite3 ]; then

	mkdir -p /relay/lnbits/lnbits-legend/data

	chown lnbits:lnbits /relay/lnbits/lnbits-legend/data

	echo "…we created a new SQLite3 DB"

else
	echo "…we have a DB"
fi

echo "Loading up the EmbassyOS settings!"

chown lnbits:root /relay/start9/shared/c-lightning/lightning-rpc

cp /relay/start9/public/lnd/admin.macaroon /home/lnbits/app/
chown lnbits:lnbits /home/lnbits/app/admin.macaroon

#exec su -s /bin/sh -c '/home/lnbits/.local/echo_lnbits_envs' lnbits
	
exec su -s /bin/ash -c '/home/lnbits/.local/lnbits_startup_script.sh' lnbits -l
