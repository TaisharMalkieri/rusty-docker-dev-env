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

echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts.git"
git fetch --depth 1 --branch v2.2.2 https://github.com/ryanoasis/nerd-fonts.git
fc-cache -v
echo "Installed jetbrainsmono!"

echo "[-] Download devicons [-]"
echo "https://github.com/ryanoasis/nerd-fonts.git"
git fetch --depth 1 --branch v1.7.7 https://github.com/vorillaz/devicons.git
fc-cache -v
echo "Installed devicons!"

export STARSHIP_CONFIG="~/dev/rusty/rusty-docker-dev-env/.config/starship/starship.toml"
export STARSHIP_CACHE=~"~/dev/rusty/rusty-docker-dev-env/.config/starship/error-cache"

curl https://starship.rs/install.sh | sh --force --verbose


