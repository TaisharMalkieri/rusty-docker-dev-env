FROM debian:bullseye as development

ARG RUST_STABILITY_VERSION
ARG USERNAME
ARG UID
ARG GID
ARG PASSWORD
ARG GROUP_NAME="user"

ARG GIT_USER
ARG GIT_EMAIL

ARG RUSTUP_HOME="/usr/local/rustup"
ARG CARGO_HOME="/usr/local/cargo"
ARG RUST_INIT_VERSION="1.24.3"
ARG RUST_ANALYZER_VERSION="2022-10-24"


ENV GIT_USER=$GIT_USER
ENV GIT_EMAIL=$GIT_EMAIL

ENV RUSTUP_HOME=$RUSTUP_HOME
ENV CARGO_HOME=$CARGO_HOME


# Copy shell build commands into build environment
COPY ./build/dev/*.sh /tmp/backend-build/

# Create a build linux user
ARG INIT_USERNAME="init"
ARG INIT_UID=$INIT_USERNAME
ARG INIT_GID=$INIT_USERNAME
ARG INIT_PASSWORD=$INIT_USERNAME
ARG INIT_GROUP_NAME=$INIT_USERNAME
RUN /tmp/backend-build/user.sh $INIT_USERNAME $INIT_UID  $INIT_GID $INIT_PASSWORD $INIT_GROUP_NAME
# Create a superuser with password protection
RUN /tmp/backend-build/user.sh $USERNAME $UID $GID $PASSWORD $GROUP_NAME
# Install basic Linux utilities: Git, Curl, Wget, Unzip, Tree etc
RUN tmp/backend-build/utilities.sh $GIT_USER $GIT_EMAIL

# Set cargo path to root instead of default $HOME
ENV PATH=/usr/local/cargo/bin:$PATH
# Install rustup and basic rust configurations
RUN /tmp/backend-build/rust.sh RUST_VERSION RUSTUP_INIT_VERSION

# Copies the zshenv file containing the project DOTDIR location, redirecting configuration from $HOME to .config/ZSH.
COPY ./build/dev/shell/.zshenv $HOME/
# Depends on user.sh and utilities.sh
ENV STARSHIP_CONFIG="$HOME/dev/rusty-docker-dev-env/.config/starship/starship.toml"
ENV STARSHIP_CACHE=~"$HOME/dev/rusty-docker-dev-env/.config/starship/error-cache/"

RUN /tmp/backend-build/shell.sh
#USER $INIT_USERNAME

# RUN /tmp/backend-build/cargo.sh
ENTRYPOINT [ "/usr/bin/zsh" ]

# FROM rust:latest as prod
