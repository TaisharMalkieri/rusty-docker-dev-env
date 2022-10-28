#!/usr/bin/env bash

# Depends on user.sh
# Depends on rust.sh
# Install zsh

if ! type zsh > /dev/null 2>&1; then
    apt_get_update_if_needed                    &&\
    apt-get install -y  --no-install-recommends zsh wget zplug nano locales fontconfig &&\
    apt-get update                              &&\
    apt-get autoremove -y                       &&\
    apt-get clean -y                            &&\
    rm -r /var/cache/* /var/lib/apt/lists/*     &&\
    chsh -s "$(which zsh)"
fi

apt-get update -y && \
    apt-get install -y --no-install-recommends zsh zplug nano locales wget && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -r /var/cache/* /var/lib/apt/lists/*

mkdir -p /usr/local/share/fonts/

apt-get install fontconfig                  &&\
wget  --directory-prefix="/tmp/" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip &&\
unzip -o -qq /tmp/Meslo.zip -d /usr/local/share/fonts/Meslo   &&\
rm /usr/local/share/fonts/Meslo/*Windows*              &&\
fc-cache -fv                                &&\
rm -rf /tmp/*                               &&\
echo "Installed primary font Meslo!"


wget  --directory-prefix="/tmp/" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraMono.zip &&\
unzip -o -qq /tmp/FiraMono.zip -d /usr/local/share/fonts/FiraMono &&\
rm /usr/local/share/fonts/FiraMono/*Windows*            &&\
fc-cache -fv                              &&\
rm -rf /tmp/*                             &&\
echo "Installed backup font Fira!"


wget  --directory-prefix="/tmp/" https://github.com/vorillaz/devicons/archive/master.zip &&\
unzip -o -qq /tmp/master.zip -d /usr/local/share/fonts/devicons &&\
rm /usr/local/share/fonts/devicons/*Windows*           &&\
fc-cache -fv                              &&\
rm -rf /tmp/*                             &&\
echo "Installed devicons!"

curl -sS https://starship.rs/install.sh | sh -s -- --yes

