FROM debian:bullseye as Dev

ARG RUSTUP_HOME=/usr/local/rustup 
ARG CARGO_HOME=/usr/local/cargo
ARG PATH=/usr/local/cargo/bin:$PATH

ARG RUST_VERSION="stable"
ARG USERNAME
ARG UID
ARG GID
ARG ZSH
ARG ZSH_THEME

ARG GIT_USER
ARG GIT_EMAIL

ENV RUSTUP_HOME=$RUSTUP_HOME 
ENV CARGO_HOME=$CARGO_HOME


COPY ./build/dev/shell/starship.toml ~/.config/ 
COPY ./build/dev/shell.sh /tmp/backend-build/
ADD ./build/dev/*.sh /tmp/backend-build/

RUN /tmp/backend-build/user.sh $USERNAME $UID $GID
RUN /tmp/backend-build/utilities.sh $GIT_USER $GIT_EMAIL

ENV PATH=/usr/local/cargo/bin:$PATH
RUN /tmp/backend-build/rust.sh $RUST_VERSION $RUSTUP_HOME $CARGO_HOME $RUST_ANALYZER_VERSION
RUN /tmp/backend-build/shell.sh


COPY ./build/dev/shell/.zshrc ./build/dev/shell/.bashrc /root/

USER $USERNAME
# RUN /tmp/backend-build/cargo.sh

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENTRYPOINT [ "/usr/bin/zsh" ]

# FROM rust:latest as prod
