#!/usr/bin/env bash

# Depends on user.sh
# Depends on rust.sh
# Install zsh

export ZDOTDIR="~/dev/rusty/rusty-docker-dev-env/.config/zsh"

if ! type zsh > /dev/null 2>&1; then
    apt_get_update_if_needed
    apt-get install -y zsh
    apt-get update
    chsh -s /usr/bin/zsh
fi
# Install oh-my-zsh
chsh -s $(which zsh)

apt-get install fontconfig                &&\
wget --directory-prefix="tmp/" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip &&\
unzip tmp/Meslo.zip -d .local/share/fonts &&\
rm .local/share/fonts/*Windows*           &&\
fc-cache -fv                              &&\
rm -rf /tmp/*                             &&\
echo "Installed font!"

export STARSHIP_CONFIG="~/dev/rusty/rusty-docker-dev-env/.config/starship/starship.toml"
export STARSHIP_CACHE=~"~/dev/rusty/rusty-docker-dev-env/.config/starship/error-cache"

curl -sS https://starship.rs/install.sh | sh
