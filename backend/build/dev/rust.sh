#!/usr/bin/env bash

RUST_VERSION=1.63.0
RUSTUP_INIT_VERSION=1.24.3
RUSTUP_HOME=/usr/local/rustup \
CARGO_HOME=/usr/local/cargo \
PATH=/usr/local/cargo/bin:$PATH
RUST_ANALYZER_VERSION=2022-08-22


# Fetch machine hardware
arch="$(uname -m)"
# Match hardware to rust sys requirements
case "$arch" in \
x86_64) rustArch='x86_64-unknown-linux-gnu'; rustupSha256='3dc5ef50861ee18657f9db2eeb7392f9c2a6c95c90ab41e45ab4ca71476b4338' ;; \
aarch64) rustArch='aarch64-unknown-linux-gnu'; rustupSha256='32a1532f7cef072a667bac53f1a5542c99666c4071af0c9549795bbdb2069ec1' ;; \
*) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ; \
esac

echo "Installing rust-"${RUST_VERSION}", rustup-"${RUSTUP_INIT_VERSION}", rust-analyzer "${RUST_ANALYZER_VERSION}" for "$arch""
export RUSTUP_HOME=/usr/local/rustup \
export CARGO_HOME=/usr/local/cargo \
export PATH=/usr/local/cargo/bin:$PATH

curl --proto '=https' --tlsv1.2 https://sh.rustup.rs | bash -s -- -y \
    --profile minimal                       \
    --default-toolchain ${RUST_VERSION}     \
    --default-host ${rustArch}              \
    --component add clippy rustfmt rust-src
    
apt-get update \
&& apt-get -y install --no-install-recommends gcc libc6-dev musl-tools \
&& apt-get clean \
ln -s /usr/bin/gcc /usr/bin/"$(uname -m)"-linux-musl-gcc

wget -qO- "https://github.com/rust-analyzer/rust-analyzer/releases/download/${RUST_ANALYZER_VERSION}/rust-analyzer-$(uname -m)-unknown-linux-gnu.gz" | \
gunzip > /usr/local/bin/rust-analyzer && \
chmod 500 /usr/local/bin/rust-analyzer