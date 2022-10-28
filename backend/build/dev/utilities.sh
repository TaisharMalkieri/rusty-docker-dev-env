#!/usr/bin/env bash

# Install curl, wget, git

apt-get update                  \
&& apt-get install -y git       \
&& apt-get install -y curl      \
&& apt-get install -y wget      \
&& apt-get install -y unzip     \
&& apt-get install -y unzip     \
&& apt-get update               \
&& apt upgrade -y               \
&& apt-get clean

git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_EMAIL}"

git config --global --replace-all alias.am "!git commit --ammend --no-edit"
git config --global --replace-all alias.save "!git add -A && git commit -m 'chore: commit save point'"
git config --global --replace-all alias.save "!git rebase -i"

