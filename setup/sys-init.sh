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

asdf-direnv-setup() {
    echo "### Setting up asdf and direnv"
    hash brew && brew install asdf
    mkdir -p "$HOME/.config/direnv"
    pushd "$HOME"
    asdf plugin-add direnv || :
    asdf direnv setup --shell zsh --version system
    #asdf global direnv latest
    popd
    ln -sf "$dotFilesDir/direnvrc" "$HOME/.config/direnv/direnvrc" || :
    ln -sf "$dotFilesDir/direnv.toml" "$HOME/.config/direnv/direnv.toml" || :
    touch "$HOME/.envrc"
}

echo ### Cloning zcomet
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git "${ZDOTDIR:-${HOME}}/.zcomet/bin"
fi

#echo "Linking dot files..."
#linkdot "p10k.zsh"

echo "### Define global gitignore"
git config --global core.excludesfile $(
    cd "$(dirname $0)"
    pwd
)/gitignore_global

asdf-direnv-setup

echo "### Installing TPM"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm ||:

./setup/hook-login-script.sh
