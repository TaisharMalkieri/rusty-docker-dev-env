FROM rust:bullseye as Dev
#   RUSTUP_HOME=/usr/local/rustup \
#    CARGO_HOME=/usr/local/cargo \
#    PATH=/usr/local/cargo/bin:$PATH \
#    RUST_VERSION=1.64.0

RUN apt-get update \
    && apt-get install -y git \
    && apt-get install -y curl \
    && apt-get install -y clean

RUN mkdir tmp
COPY ./build/*.sh /tmp/

RUN ./tmp/cargo.sh

FROM rust:latest as prod
