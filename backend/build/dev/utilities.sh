# Install zsh
GIT_USER=${1}
GIT_EMAIL=${2}

apt-get update                  \
&& apt-get install -y git       \
&& apt-get install -y curl      \
&& apt-get install -y wget      \
&& apt-get update               \
&& apt upgrade -y               \
&& apt-get clean

git config --local user.name "tormod"
git config --local user.email "tormod_tho@hotmail.com"

git config --local --replace-all alias.am "!git commit --ammend --no-edit"
git config --local --replace-all alias.save "!git add -A && git commit -m 'chore: commit save point'"
git config --local --replace-all alias.save "!git rebase -i"

