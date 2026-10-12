#!/usr/bin/env bash

set -e

kitty_d_dir="$(pwd)/dotfiles/kitty.d"
kitty_conf_dir="$HOME/.config/kitty"

[ -d "$kitty_conf_dir" ] || exit 0

echo "### Linking kitty config"
echo ln -s "$kitty_d_dir" "$kitty_conf_dir" || :

if [ -f "$kitty_conf_dir/current-theme.conf" ]; then
    ln -s "$kitty_conf_dir/current-theme.conf" "$kitty_d_dir" || :
fi

echo
echo "### MANUAL ACTION ###"
echo "Add 'globinclude kitty.d/*.conf' to $HOME/.config/kitty/kitty.conf"
