LNBITS_SRC := $(shell find ./lnbits-legend/lnbits)

.DELETE_ON_ERROR:

all: lnbitslegend-lite.s9pk

install: lnbits.s9pk
	appmgr install lnbits.s9pk

lnbitslegend-lite.s9pk: manifest.yaml config_spec.yaml config_rules.yaml image.tar instructions.md icon.png
	appmgr -vv pack $(shell pwd) -o lnbitslegend-lite.s9pk
	appmgr -vv verify lnbitslegend-lite.s9pk

instructions.md: README.md
	cp README.md instructions.md

image.tar: Dockerfile docker_entrypoint.sh $(LNBITS_SRC)
	DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --security-opt=seccomp=unconfined --tag start9/lnbitslegend-lite --platform=linux/arm/v7 -o type=docker,dest=image.tar .
