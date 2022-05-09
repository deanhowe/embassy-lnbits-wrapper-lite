ASSETS := $(shell yq e '.assets.[].src' manifest.yaml)
ASSET_PATHS := $(addprefix assets/,$(ASSETS))
VERSION := $(shell yq e ".version" manifest.yaml)
LNBITS_LITE_SRC := $(shell find ./lnbits-legend/lnbits)
#MANAGER_SRC := $(shell find ./manager -name '*.rs') manager/Cargo.toml manager/Cargo.lock

S9PK_PATH=$(shell find . -name lnbits-lite.s9pk -print)

# delete the target of a rule if it has changed and its recipe exits with a nonzero exit status
.DELETE_ON_ERROR:

all: verify

verify: lnbits-lite.s9pk $(S9PK_PATH)
		embassy-sdk verify s9pk $(S9PK_PATH)

clean:
	rm -f image.tar
	rm -f lnbits-lite.s9pk
	
lnbits-lite.s9pk: config_spec.yaml config_rules.yaml image.tar instructions.md $(ASSET_PATHS)
	embassy-sdk pack
		
# --security-opt=seccomp=unconfined --tag

image.tar: Dockerfile docker_entrypoint.sh check-web.sh configs-get.sh $(LNBITS_LITE_SRC)
		DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --tag start9/lnbits-lite/main:$(VERSION) --platform=linux/arm64 -o type=docker,dest=image.tar .

#manager/target/aarch64-unknown-linux-musl/release/bitcoind-manager: $(MANAGER_SRC)
#	docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)"/manager:/home/rust/src start9/rust-musl-cross:aarch64-musl cargo build --release
	
#lnbits-lite/target/aarch64-unknown-linux-musl/release/lnbits-lite
#lnbits-lite/target/aarch64-unknown-linux-musl/release/lnbits-lite: $(LNBITS_LITE_SRC)
#		docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)"/lnbits-lite:/home/rust/src start9/rust-musl-cross:aarch64-musl cargo build --release
		#docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)"/lnbits-lite:/home/rust/src start9/rust-musl-cross:aarch64-musl cargo +beta build --release
		

#manifest.yaml: lnbits-lite/Cargo.toml
#		yq e -i '.version="$(VERSION)"' manifest.yaml
