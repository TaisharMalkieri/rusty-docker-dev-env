FROM debian:bullseye as Dev
#   RUSTUP_HOME=/usr/local/rustup \
#   CARGO_HOME=/usr/local/cargo \
#   PATH=/usr/local/cargo/bin:$PATH \
#   RUST_VERSION=1.64.0
ARG USERNAME
ARG UID
ARG GID
ARG ZSH
ARG ZSH_THEME

ARG GIT_USER
ARG GIT_EMAIL

COPY ./build/dev/*.sh /tmp/backend-build/

RUN sudo /tmp/backend-build/utilities.sh GIT_USER GIT_EMAIL
RUN sudo /tmp/backend-build/user.sh USERNAME UID GID ZSH ZSH_THEME
RUN sudo /tmp/backend-build/rust.sh
RUN sudo /tmp/backend-build/cargo.sh
RUN sudo /tmp/backend-build/shell.sh
FROM rust:latest as prod
