#!/usr/bin/env bash

RUST_VERSION=${1:-"stable"}
RUSTUP_INIT_VERSION=${2:-"1.24.3"}
RUST_ANALYZER_VERSION=${3:-"2022-08-22"}
RUSTUP_HOME=${4:-"/usr/local/rustup"}
CARGO_HOME=${5:-"/usr/local/cargo"}



PATH=/usr/local/cargo/bin:$PATH

# Fetch machine hardware
arch="$(uname -m)"
# Match hardware to rust sys requirements
case "$arch" in \
x86_64) rustArch='x86_64-unknown-linux-gnu'; rustupSha256='3dc5ef50861ee18657f9db2eeb7392f9c2a6c95c90ab41e45ab4ca71476b4338' ;; \
aarch64) rustArch='aarch64-unknown-linux-gnu'; rustupSha256='32a1532f7cef072a667bac53f1a5542c99666c4071af0c9549795bbdb2069ec1' ;; \
*) echo >&2 "unsupported architecture"; exit 1 ; \
esac

echo "Installing rust-$RUST_VERSION, rustup-$RUSTUP_INIT_VERSION, rust-analyzer $RUST_ANALYZER_VERSION for $arch"

mkdir RUSTUP_HOME
export RUSTUP_HOME
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs | bash -s -- -y \
    --no-modify-path                        \
    --profile minimal                       \
    --default-toolchain "$RUST_VERSION"     \
    --default-host "$rustArch"             \
    --component add clippy rustfmt rust-src

mkdir CARGO_HOME
export CARGO_HOME
apt-get update && \
apt-get -y install --no-install-recommends gcc libc6-dev musl-tools && \
apt-get clean && \
ln -s /usr/bin/gcc /usr/bin/"$(uname -m)"-linux-musl-gcc && \
chmod -R a+w "${RUSTUP_HOME}" "${CARGO_HOME}"
#rustup default stable

wget -qO- "https://github.com/rust-analyzer/rust-analyzer/releases/download/$RUST_ANALYZER_VERSION/rust-analyzer-$(uname -m)-unknown-linux-gnu.gz" | \
gunzip > /usr/local/bin/rust-analyzer && \
chmod 500 /usr/local/bin/rust-analyzer

# Install dev-ops packages
cargo install cargo-binstall
cargo install --locked cargo-chef
cargo binstall cargo-binstall --no-confirm

cargo binstall  --no-confirm        \
                cargo-expand        \
                cargo-outdated      \
                cargo-watch         \
                cargo-geiger        \
                cargo-about         \
                cargo-spellcheck    \
                cargo-inspect       \
                cargo-audit         \
                cargo-clippy        \