FROM rust:bullseye as Dev
#   RUSTUP_HOME=/usr/local/rustup \
#   CARGO_HOME=/usr/local/cargo \
#   PATH=/usr/local/cargo/bin:$PATH \
#   RUST_VERSION=1.64.0

RUN apt-get update \
    && apt-get install -y git \
    && apt-get install -y curl \
    && apt-get install -y zsh \
    && apt-get update \
    && apt-get clean

COPY ./build/*.sh /tmp/backend-build/

RUN ./tmp/backend-build/cargo.sh

FROM rust:latest as prod
