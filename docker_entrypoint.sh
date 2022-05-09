#!/bin/sh

set -ea

export HOST_IP=$(ip -4 route list match 0/0 | awk '{print $3}')
export WHO_AM_I=$(whoami)

echo "Command = $1"

if [ ! -f /home/lnbits/.profile ]; then
	echo "First Boot!"
	echo PATH=/home/lnbits/.local/bin/:$PATH > /home/lnbits/.profile
	chown lnbits:lnbits /home/lnbits/.profile
	
	mkdir -p /home/lnbits/app/5000
	cp -pr /home/lnbits/app/lnbits/lnbits-legend /home/lnbits/app/5000/lnbits
	
	mkdir -p /home/lnbits/app/5001
	cp -pr /home/lnbits/app/lnbits/lnbits-legend /home/lnbits/app/5001/lnbits

	mkdir -p /home/lnbits/app/5002
	cp -pr /home/lnbits/app/lnbits/lnbits-legend /home/lnbits/app/5002/lnbits

	mkdir -p /home/lnbits/app/5003
	cp -pr /home/lnbits/app/lnbits/lnbits-legend /home/lnbits/app/5003/lnbits

	mkdir -p /home/lnbits/app/5004
	cp -pr /home/lnbits/app/lnbits/lnbits-legend /home/lnbits/app/5004/lnbits

	mkdir -p /home/lnbits/app/5005
	cp -pr /home/lnbits/app/lnbits/lnbits-legend /home/lnbits/app/5005/lnbits
	
	/home/lnbits/.local/echo_lnbits_envs
	
	chown -R lnbits:lnbits /home/lnbits/app/500*
fi

if [ "$1" = "install-c-lightning" ]; then
	echo "Installing the C-Lightning Python libraries…"
	su -s /bin/sh -c 'pip3 install pylightning' lnbits
	echo "Installed… please restart your LNBits Service"
	exit 0
elif [ "$1" = "install-lnd-libraries" ]; then
	echo "Installing the LND Python libraries…"
	su -s /bin/sh -c 'pip3 install lndgrpc purerpc' lnbits
	echo "Installed… please restart your LNBits Service"
	exit 0
elif [ "$1" = "start-sqlite-web" ]; then
	echo "Installing the libraries…"
	su -s /bin/sh -c 'sqlite_web /datadir/lnbits/lnbits-legend/data/database.sqlite3 --no-browser' lnbits
	echo "Installed… "
	exit 0
else

#	su -s /bin/sh -c 'pip3 install sqlite-web' lnbits	

echo "Welcome to the LNBits community!"

echo "Host IP - $HOST_IP"

echo "Currently running in Docker as $WHO_AM_I"

echo "Checking if we have an SQLite3 DB…"

if [ ! -f /datadir/lnbits/lnbits-legend/data/database.sqlite3 ]; then
	mkdir -p /datadir/lnbits/lnbits-legend/data

	chown lnbits:lnbits /datadir/lnbits/lnbits-legend/data
	
	echo "…we created a new SQLite3 DB"

else
	echo "…we have a DB"
fi

if [ ! -d /datadir/lnbits/lnbits-legend/5000/data ]; then

	mkdir -p /datadir/lnbits/lnbits-legend/5000/data && chown -R lnbits:lnbits /datadir/lnbits/lnbits-legend/5000
	echo "…we created a data store for Instance I"

else
	echo "…we have a data store for Instance I"
fi

if [ ! -d /datadir/lnbits/lnbits-legend/5001/data ]; then

	mkdir -p /datadir/lnbits/lnbits-legend/5001/data && chown -R lnbits:lnbits /datadir/lnbits/lnbits-legend/5001
	echo "…we created a data store for Instance II"

else
	echo "…we have a data store for Instance II"
fi

if [ ! -d /datadir/lnbits/lnbits-legend/5002/data ]; then

	mkdir -p /datadir/lnbits/lnbits-legend/5002/data && chown -R lnbits:lnbits /datadir/lnbits/lnbits-legend/5002
	echo "…we created a data store for Instance III"

else
	echo "…we have a data store for Instance III"
fi

if [ ! -d /datadir/lnbits/lnbits-legend/5003/data ]; then

	mkdir -p /datadir/lnbits/lnbits-legend/5003/data && chown -R lnbits:lnbits /datadir/lnbits/lnbits-legend/5003
	echo "…we created a data store for Instance IV"

else
	echo "…we have a data store for Instance IV"
fi

if [ ! -d /datadir/lnbits/lnbits-legend/5004/data ]; then

	mkdir -p /datadir/lnbits/lnbits-legend/5004/data && chown -R lnbits:lnbits /datadir/lnbits/lnbits-legend/5004
	echo "…we created a data store for Instance V"

else
	echo "…we have a data store for Instance V"
fi

if [ ! -d /datadir/lnbits/lnbits-legend/5005/data ]; then

	mkdir -p /datadir/lnbits/lnbits-legend/5005/data && chown -R lnbits:lnbits /datadir/lnbits/lnbits-legend/5005
	echo "…we created a data store for Instance VI"

else
	echo "…we have a data store for Instance VI"
fi

echo "Loading up the EmbassyOS settings!"

chown lnbits:root /mnt/c-lightning/lightning-rpc



cp /mnt/lnd/admin.macaroon /home/lnbits/app/
chown lnbits:lnbits /home/lnbits/app/admin.macaroon

#exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_startup_script.sh' lnbits

fi

#exec tini lnbits-lite
exec tail -f /var/log/lnbits.log