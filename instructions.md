# Instructions for LNBits LEGEND LITE…

SSH into your embassy and run the following commands

	sudo appmgr install lnbitslegend-lite.s9pk
	sudo docker exec -i -t lnbitslegend-lite /bin/sh
	

Install C-Lightning…

	sudo su lnbits -s /bin/sh
	pip3 install pylightning
	exit


	nano /home/lnbits/.local/lnbits_startup_script.sh

Scroll to the bottom of the script uncomment the lines 

```
#quart assets
#quart migrate
```

Save the changes and then test your changes…

	/home/lnbits/.local/docker_entrypoint.sh
	

```
#exec hypercorn -k trio --bind 0.0.0.0:5005 'lnbits.app:create_app()'
```

And comment out the `exec tail -f /dev/null` that is currently keeping the container running.

#exec tail -f /dev/null


Test your changes…

	/home/lnbits/.local/docker_entrypoint.sh
	
Logout of the docker instance and restart the service.

	sudo appmgr restart lnbitslegend-lite.s9pk

You'll see something like this…

```
Host IP - 172.18.0.1
Currently running in Docker as root

...

lnbits.app:create_app()
  ✔️ CLightningWallet seems to be connected and with a balance of XXXXXXXXXx msat.
[20XX-XX-XX 01:33:70 +0000] [42] [INFO] Running on http://0.0.0.0:5005 (CTRL + C to quit)
```	

Instructions go here.

# LNBits [LEGEND] on Embassy OS

Free Open-Source Lightning Accounts System with Extensions

Running on your Embassy for yourself, for others, or as part of a stack.

LNbits extension framework makes building on Bitcoin easy.

## Features

LNbits can run on top of any lightning-network funding source, currently there is support for LND, c-lightning, Spark, LNpay, OpenNode, lntxbot, with more being added regularly.

- [Accounts System](https://lnbits.com/#api) Create multiple accounts/wallets. Run for yourself, friends/family, or the whole world!

- [Extensions](https://lnbits.com/#extensions) Access dozens of extensions made by contrinbutors, or build your own.

- [Stack](https://lnbits.com/#api) One simple API, able to connect to multiple nodes/funding sources. Extensions include APIs.

- [Instant wallet](https://lnbits.com/#wallet) Use instantly and directly in browser on desktop or phone, no need to download any apps.

## LNbits Community

LNbits has an incredible community of users and developers, exchanging ideas, helping each other, and extending the free and open-source software

Join the telegram group [t.me/lnbits](https://t.me/lnbits)