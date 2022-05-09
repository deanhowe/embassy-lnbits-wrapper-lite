#!/bin/sh

export PATH=/home/lnbits/.local/bin/:$PATH

#for I in $(seq 1 5);
#do
#    echo "BLINK!"
#    sleep 1
#done

#if [ ! ( which hyoercorns) ]; then
#       echo "WHAT"
#fi


if [ "$1" = "install-c-lightning" ]; then
	if pip3 show -qqq pylightning 2>/dev/null; then
		echo "pylightning alreday installed"
	else
		echo "Installing the C-Lightning Python libraries…"
		su -s /bin/sh -c 'pip3 install pylightning' lnbits
		echo "Installed… pylightning on demand"
	fi	
	exit 0
elif [ "$1" = "install-lnd-libraries" ]; then
	echo "Installing the LND Python libraries…"
	su -s /bin/sh -c 'pip3 install lndgrpc purerpc' lnbits
	echo "Installed… lndgrpc purerpc on demand"
	exit 0
elif [ "$1" = "install-sqlite-web" ]; then
	echo "Install SQLite WEB…"
	su -s /bin/sh -c 'pip3 install sqlite-web' lnbits
	echo "Installed… sqlite-web"
	exit 0
elif [ "$1" = "start-sqlite-web" ]; then
	echo "Starting SQLite WEB…"
	su -s /bin/sh -c 'sqlite_web /relay/lnbits/lnbits-legend/data/database.sqlite3 -H 0.0.0.0 -x -r &' lnbits
	echo "SQLite WEB started in READ ONLY MODE…"
	exit 0
elif [ "$1" = "start-sqlite-web-write" ]; then
	echo "Starting SQLite WEB…"
	su -s /bin/sh -c 'sqlite_web /relay/lnbits/lnbits-legend/data/database.sqlite3 -H 0.0.0.0 -x A' lnbits
	echo "SQLite WEB started in ADMIN MODE…"
	exit 0
elif [ "$1" = "install-nano" ]; then
	echo "Installing Nano"
	apk add nano
	echo "Nano installed"
	exit 0
elif [ "$1" = "stop-lnbits" ]; then
	echo "Stopping LNBits"
	kill $(cat /tmp/hypercorn-5000.pid)
	echo "LNBits Stopped"
	exit 0
elif [ "$1" = "start-lnbits" ]; then
	echo "Starting LNBits"
	exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_startup_script.sh' lnbits
	echo "LNBits Started"
	exit 0
elif [ "$1" = "start-lnbits-two" ]; then
	/home/lnbits/.local/echo_lnbits_envs
	echo "Starting LNBits II"
	exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_instance_startup.sh 1' lnbits
	echo "LNBits II Started"
	exit 0
elif [ "$1" = "stop-lnbits-two" ]; then
	echo "Stopping LNBits II"
	kill $(cat /tmp/hypercorn-5001.pid)
	echo "LNBits II Stopped"
	exit 0
elif [ "$1" = "start-lnbits-three" ]; then
	echo "Starting LNBits III"
	exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_instance_startup.sh 2' lnbits
	echo "LNBits III Started"
	exit 0
elif [ "$1" = "stop-lnbits-three" ]; then
	echo "Stopping LNBits III"
	kill $(cat /tmp/hypercorn-5002.pid)
	echo "LNBits III Stopped"
	exit 0
elif [ "$1" = "start-lnbits-four" ]; then
	echo "Starting LNBits IV"
	exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_instance_startup.sh 3' lnbits
	echo "LNBits IV Started"
	exit 0
elif [ "$1" = "stop-lnbits-four" ]; then
	echo "Stopping LNBits IV"
	kill $(cat /tmp/hypercorn-5003.pid)
	echo "LNBits IV Stopped"
	exit 0
elif [ "$1" = "start-lnbits-five" ]; then
	echo "Starting LNBits V"
	exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_instance_startup.sh 4' lnbits
	echo "LNBits V Started"
	exit 0
elif [ "$1" = "stop-lnbits-five" ]; then
	echo "Stopping LNBits V"
	kill $(cat /tmp/hypercorn-5004.pid)
	echo "LNBits V Stopped"
	exit 0
elif [ "$1" = "start-lnbits-six" ]; then
	echo "Starting LNBits VI"
	exec su -s /bin/sh -c '/home/lnbits/.local/lnbits_instance_startup.sh 5' lnbits
	echo "LNBits II Started"
	exit 0
elif [ "$1" = "stop-lnbits-six" ]; then
	echo "Stopping LNBits VI"
	kill $(cat /tmp/hypercorn-5005.pid)
	echo "LNBits VI Stopped"
	exit 0
fi

if hash pylightning 2>/dev/null; then
  echo "We have Hypercorn!"
else
  echo "Sorry no Hypercorn!"
fi

if pip3 show -qqq pylightning 2>/dev/null; then
  echo "yes we have pylightning"
else
  echo "no pylightning installed"
fi