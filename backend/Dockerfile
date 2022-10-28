FROM debian:bullseye as Dev

ARG RUSTUP_HOME="/usr/local/rustup"
ARG CARGO_HOME="/usr/local/cargo"
ARG PATH="/usr/local/cargo/bin:$PATH"

ARG RUST_VERSION="stable"
ARG RUST_ANALYZER_VERSION="2022-10-24"
ARG USERNAME
ARG UID
ARG GID
ARG ZSH
ARG ZSH_THEME

ARG GIT_USER
ARG GIT_EMAIL

ENV RUSTUP_HOME=$RUSTUP_HOME
ENV CARGO_HOME=$CARGO_HOME
ENV PATH=/usr/local/cargo/bin:$PATH

COPY ./build/dev/*.sh /tmp/backend-build/

RUN /tmp/backend-build/user.sh $USERNAME $UID $GID
RUN tmp/backend-build/utilities.sh $GIT_USER $GIT_EMAIL

RUN /tmp/backend-build/rust.sh $RUST_VERSION $RUSTUP_HOME $CARGO_HOME $RUST_ANALYZER_VERSION

# Depends on user.sh and utilities.sh
RUN mkdir /home/$USERNAME/.config/
COPY ./build/dev/shell/.zshrc ./build/dev/shell/.bashrc /root/
COPY ./build/dev/shell/starship.toml /home/$USERNAME/.config/
RUN /tmp/backend-build/shell.sh
USER $USERNAME
# RUN /tmp/backend-build/cargo.sh

ENTRYPOINT [ "/usr/bin/zsh" ]

# FROM rust:latest as prod
