#!/usr/bin/env bash

set -e

kittydDir="$(pwd)/dotfiles/kitty.d"
kittyConfDir="$HOME/.config/kitty"

[ -d "$kittyConfDir" ] || exit 0

echo "### Linking kitty config"
echo ln -s "$kittydDir" "$kittyConfDir" || :

if [ -f "$kittyConfDir/current-theme.conf" ]; then
    ln -s "$kittyConfDir/current-theme.conf" "$kittydDir" || :
fi

echo
echo "### MANUAL ACTION ###"
echo "Add 'globinclude kitty.d/*.conf' to $HOME/.config/kitty/kitty.conf"
