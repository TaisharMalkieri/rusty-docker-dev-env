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

COPY ./build/dev/shell/starship.toml ~/.config/ 
COPY ./build/dev/shell.sh /tmp/backend-build/
ADD ./build/dev/*.sh /tmp/backend-build/

RUN /tmp/backend-build/user.sh USERNAME UID GID
RUN /tmp/backend-build/utilities.sh GIT_USER GIT_EMAIL

RUN /tmp/backend-build/rust.sh
RUN /tmp/backend-build/shell.sh

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT [ "/usr/bin/zsh" ]
COPY ./build/dev/shell/.zshrc ./build/dev/shell/.bashrc /root/

USER USERNAME
RUN /tmp/backend-build/cargo.sh
FROM rust:latest as prod
