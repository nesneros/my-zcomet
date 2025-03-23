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
    to=$HOME/.$file
    echo " - linking $file ($to -> $from)"
    ln -sf "$from" "$to"
}

echo ### Cloning zcomet
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git "${ZDOTDIR:-${HOME}}/.zcomet/bin"
fi

echo "### Setup Mise"
mkdir -p "$HOME/.config/mise/conf.d"
ln -sf "$dotFilesDir/mise-global.toml" "$HOME/.config/mise/conf.d/my-zcomet.toml"
mise install

#echo "Linking dot files..."
#linkdot "p10k.zsh"

echo "### Define global gitignore"
git config --global core.excludesfile $(
    cd "$(dirname $0)"
    pwd
)/gitignore_global

# echo "### Installing TPM"
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm ||:

./setup/hook-login-script.sh
