FROM debian:bullseye as Dev
ARG RUST_VERSION
ARG USERNAME
ARG UID
ARG GID
ARG GIT_USER
ARG GIT_EMAIL

ARG RUSTUP_HOME="/usr/local/rustup"
ARG CARGO_HOME="/usr/local/cargo"
ARG RUST_ANALYZER_VERSION="2022-10-24"


ENV GIT_USER=${GIT_USER}
ENV GIT_EMAIL=${GIT_EMAIL}
ENV USERNAME=${USERNAME}
ENV UID=${UID}
ENV GID=${GID}

ENV RUSTUP_HOME=${RUSTUP_HOME}
ENV CARGO_HOME=${CARGO_HOME}


COPY ./build/dev/shell.sh /tmp/backend-build/
COPY ./build/dev/*.sh /tmp/backend-build/

RUN /tmp/backend-build/user.sh $USERNAME $UID $GID
RUN tmp/backend-build/utilities.sh $GIT_USER $GIT_EMAIL


ENV PATH=/usr/local/cargo/bin:$PATH
RUN /tmp/backend-build/rust.sh $RUST_VERSION $RUSTUP_HOME $CARGO_HOME $RUST_ANALYZER_VERSION

# Depends on user.sh and utilities.sh

ENV ZDOTDIR="$HOME/dev/rusty-docker-dev-env.config/zsh"
ENV STARSHIP_CONFIG="$HOME/dev/rusty-docker-dev-env/.config/starship/starship.toml"
ENV STARSHIP_CACHE=~"/com.docker.devenvironments.code/.config/starship/error-cache/"
COPY ./build/dev/shell/.zshrc ./build/dev/shell/.bashrc /root/
COPY ./build/dev/shell/starship.toml /home/$USERNAME/.config/


RUN /tmp/backend-build/shell.sh
USER $USERNAME


# RUN /tmp/backend-build/cargo.sh

ENTRYPOINT [ "/usr/bin/zsh" ]

# FROM rust:latest as prod
