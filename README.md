# Instructions for LNBits LEGEND LITE…

Build the service and copy the compiled `lnbits-lite.s9pk` file to your Embassy

SSH into your embassy and run the following commands

	sudo embassy-cli package install lnbits-lite.s9pk 
	sudo docker exec -i -t lnbits-lite /bin/sh

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

Save the changes and then test your changes… (confirm overwriting the `.env` file)

	/home/lnbits/.local/docker_entrypoint.sh
	
You'll see something like this…

```
Host IP - 172.18.0.1
Currently running in Docker as root

...

running migration satsdice.1
running migration satsdice.2
running migration satsdice.3
running migration satsdice.4
running migration events.1
running migration events.2
running migration watchonly.1
running migration captcha.1
running migration captcha.2
```

Re-open `/home/lnbits/.local/lnbits_startup_script.sh` and uncomment the line that executes `hypercorn`

```
#exec hypercorn -k trio --bind 0.0.0.0:5005 'lnbits.app:create_app()'
```

And comment out the line below it that's currently keeping the container running.

	#exec tail -f /dev/null

Test your changes…

	/home/lnbits/.local/docker_entrypoint.sh
	
You'll see something like this…

```
Host IP - 172.18.0.1
Currently running in Docker as root

...

lnbits.app:create_app()
  ✔️ CLightningWallet seems to be connected and with a balance of XXXXXXXXXx msat.
[20XX-XX-XX 01:33:70 +0000] [42] [INFO] Running on http://0.0.0.0:5005 (CTRL + C to quit)
```	

Logout of the docker instance and restart the service.

	sudo appmgr restart lnbitslegend-lite.s9pk


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

# Wrapper for lnbits LITE

`lnbitslegend-wrapper` is a simple, minimal project to serve as a template for creating an app for the Embassy.



## Dependencies

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [yq](https://mikefarah.gitbook.io/yq)
- [toml](https://crates.io/crates/toml-cli)
- [appmgr](https://github.com/Start9Labs/embassy-os/tree/master/appmgr)
- [make](https://www.gnu.org/software/make/)

## Build enviroment
Prepare your EmbassyOS build enviroment. In this example we are using Ubuntu 20.04.

1. Install docker
```
curl -fsSL https://get.docker.com -o- | bash
sudo usermod -aG docker "$USER"
exec sudo su -l $USER
```
2. Set buildx as the default builder
```
docker buildx install
docker buildx create --use
```
3. Enable cross-arch emulated builds in docker
```
docker run --privileged --rm linuxkit/binfmt:v0.8
```
4. Install yq
```
sudo snap install yq
```
5. Install essentials build packages
```
sudo apt-get install -y build-essential openssl libssl-dev libc6-dev clang libclang-dev ca-certificates
```
6. Install Rust
```
curl https://sh.rustup.rs -sSf | sh
# Choose nr 1 (default install)
source $HOME/.cargo/env
```
7. Install toml
```
cargo install toml-cli
```
8. Build and install appmgr
```
cd ~/ && git clone https://github.com/Start9Labs/embassy-os.git
cd embassy-os/appmgr/
cargo install --path=. --features=portable --no-default-features && cd ~/
```
Now you are ready to build your first EmbassyOS service

## Cloning

Clone the project locally. Note the submodule link to the original project(s). 

```
git clone https://github.com/Start9Labs/lnbitslegend-wrapper.git
cd lnbits-wrapper
```

## Building

To build the project, run the following commands:

```
make
```

## Installing (on Embassy)

SSH into an Embassy device.
`scp` the `.s9pk` to any directory from your local machine.
Run the following command to determine successful install:

```
sudo appmgr install lnbitslegend.s9pk
```
