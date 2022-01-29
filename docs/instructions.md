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