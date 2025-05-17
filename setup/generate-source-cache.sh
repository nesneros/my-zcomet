#!/usr/bin/env zsh
# shellcheck disable=SC2145

set -e

_add_source_cache() {
    # Just the first arg
    local cmd="$1"
    if hash "$(basename $cmd)" &>/dev/null; then
        echo "Adding $@ to source cache"
        echo "### BEGIN $@" >>"$source_cache"
        "$@" >>"$source_cache"
        echo >>"$source_cache" # Add newline incase command doesn't end with a final newline
        echo "### END $@" >>"$source_cache"
        echo >>"$source_cache"
    else
        echo "Skipping $cmd"
    fi
}

echo "Generating source cache..."
mkdir -p "$MY_ZCOMET/generated"

source_cache="$MY_ZCOMET/generated/source_cache.zsh"
rm "$source_cache" 2>/dev/null || :

# Generated oh-my-posh config
jsonnet "$MY_ZCOMET/dotfiles/oh-my-posh.jsonnet" > "$MY_ZCOMET/generated/oh-my-posh.json"

brewBins=({/opt/homebrew,/usr/local,/home/linuxbrew/.linuxbrew}/bin/brew(.N))
brewBin=${brewBins[1]}

printf "# Generated at %s\n\n" "$(date)" >>"$source_cache"

[[ -x "$brewBin" ]] && _add_source_cache "$brewBin" shellenv
_add_source_cache batpipe
_add_source_cache thefuck --alias
_add_source_cache mise activate zsh
_add_source_cache zoxide init zsh
_add_source_cache oh-my-posh init zsh --config "$MY_ZCOMET/generated/oh-my-posh.json"