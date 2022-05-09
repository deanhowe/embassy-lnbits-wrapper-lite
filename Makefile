ASSETS := $(shell yq e '.assets.[].src' manifest.yaml)
ASSET_PATHS := $(addprefix assets/,$(ASSETS))
VERSION := $(shell yq e ".version" manifest.yaml)

S9PK_PATH=$(shell find . -name lnbits-lite.s9pk -print)

# delete the target of a rule if it has changed and its recipe exits with a nonzero exit status
.DELETE_ON_ERROR:

all: verify

verify: lnbits-lite.s9pk $(S9PK_PATH)
		embassy-sdk verify s9pk $(S9PK_PATH)

clean:
	rm -f image.tar
	rm -f lnbits-lite.s9pk
	
lnbits-lite.s9pk: image.tar instructions.md $(ASSET_PATHS)
	embassy-sdk pack
		
# --security-opt=seccomp=unconfined --tag

image.tar: Dockerfile docker_entrypoint.sh
		DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/lnbits-lite/main:$(VERSION) --platform=linux/arm64 -o type=docker,dest=image.tar .

