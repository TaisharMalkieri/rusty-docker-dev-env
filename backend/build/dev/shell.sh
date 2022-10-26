#!/usr/bin/env bash

# Depends on user.sh
# Depends on rust.sh
# Install zsh

export ZDOTDIR="~/dev/rusty/rusty-docker-dev-env/.config/zsh"

if ! type zsh > /dev/null 2>&1; then
    apt_get_update_if_needed                    &&\
    apt-get install -y zsh nano locales         &&\
    apt-get update                              &&\
    apt-get autoremove -y                       &&\
    apt-get clean -y                            &&\
    rm -r /var/cache/* /var/lib/apt/lists/*     &&\
    chsh -s $(which zsh)
fi

apt-get install fontconfig                &&\
wget --directory-prefix="tmp/" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip &&\
unzip tmp/Meslo.zip -d .local/share/fonts &&\
rm .local/share/fonts/*Windows*           &&\
fc-cache -fv                              &&\
rm -rf /tmp/*                             &&\
echo "Installed font!"


export STARSHIP_CONFIG="/com.docker.devenvironments.code/.config/starship/starship.toml"
export STARSHIP_CACHE=~"/com.docker.devenvironments.code/.config/starship/error-cache/"

curl -sS https://starship.rs/install.sh | sh -s -- --yes

apt-get update -y && \
    apt-get install -y --no-install-recommends zsh zplug nano locales wget && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -r /var/cache/* /var/lib/apt/lists/*