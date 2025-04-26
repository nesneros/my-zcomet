#! /usr/bin/env bash

set -e

cd "$(dirname $0)/.."

echo "MY zcomet dir: $(pwd)"

pushd setup
brew bundle
popd

dotFilesDir=$(pwd)/dotfiles

linkdot() {
    file=$1
    from=$dotFilesDir/$file
    to="$HOME/.config/${file%.*}/$file"
    mkdir -p "$(dirname $to)"
    echo " - linking $file ($to -> $from)"
    ln -sf "$from" "$to"
}

echo ### Cloning zcomet
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git "${ZDOTDIR:-${HOME}}/.zcomet/bin"
fi

echo "### Setup Mise"
mkdir -p "$HOME/.config/mise"
ln -sf "$dotFilesDir/mise-global.toml" "$HOME/.config/mise/config.toml"
mise install

echo "### Define global gitignore"
git config --global core.excludesfile $(
    cd "$(dirname $0)"
    pwd
)/gitignore_global

echo "### Installing TPM"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm ||:
linkdot tmux.conf

./setup/hook-login-script.sh

./setup/generate-completions.sh
./setup/generate-source-cache.sh

