VERSION := $(shell yq e ".version" manifest.yaml)
LNBITS_SRC := $(shell find ./lnbits-legend/lnbits)

.DELETE_ON_ERROR:

all: lnbitslegend-lite.s9pk

install: lnbits.s9pk
	embassy-cli package install lnbits.s9pk

lnbitslegend-lite.s9pk: manifest.yaml config_spec.yaml config_rules.yaml image.tar instructions.md icon.png
	embassy-sdk pack
		
# --security-opt=seccomp=unconfined --tag

image.tar: Dockerfile docker_entrypoint.sh $(LNBITS_SRC)
		DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/lnbitslegend-lite:$(VERSION) --platform=linux/arm64 -o type=docker,dest=image.tar .