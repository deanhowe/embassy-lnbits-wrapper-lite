ASSETS := $(shell yq e '.assets.[].src' manifest.yaml)
ASSET_PATHS := $(addprefix assets/,$(ASSETS))
VERSION := $(shell yq e ".version" manifest.yaml)
LNBITS_LITE_SRC := $(shell find ./lnbits-lite/src) lnbits-lite/Cargo.toml lnbits-lite/Cargo.lock
S9PK_PATH=$(shell find . -name lnbits-lite.s9pk -print)

.DELETE_ON_ERROR:

all: verify

verify: lnbits-lite.s9pk $(S9PK_PATH)
		embassy-sdk verify $(S9PK_PATH)

#install: lnbits.s9pk
#	embassy-cli package install lnbits.s9pk

lnbits-lite.s9pk: manifest.yaml assets/compat/config_spec.yaml config_rules.yaml image.tar docs/instructions.md icon.png $(ASSET_PATHS)
	embassy-sdk pack
		
# --security-opt=seccomp=unconfined --tag

image.tar: Dockerfile docker_entrypoint.sh lnbits-lite/target/aarch64-unknown-linux-musl/release/lnbits-lite
		DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/lnbits-lite:$(VERSION) --platform=linux/arm64 -o type=docker,dest=image.tar .
		
lnbits-lite/target/aarch64-unknown-linux-musl/release/lnbits-lite: $(LNBITS_LITE_SRC)
		#docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)"/lnbits-lite:/home/rust/src start9/rust-musl-cross:aarch64-musl cargo +beta build --release
		docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)"/lnbits-lite:/home/rust/src start9/rust-musl-cross:aarch64-musl musl-strip target/aarch64-unknown-linux-musl/release/lnbits-lite

manifest.yaml: lnbits-lite/Cargo.toml
		yq e -i '.version="$(VERSION)"' manifest.yaml
