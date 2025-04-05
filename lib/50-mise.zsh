hash mise &>/dev/null || return

# If ~/etc/age.txt exists, use it as the SOPS_AGE_KEY_FILE. These env vars should be set before activating mise.
if [[ -f "$HOME/.config/mise/age.txt" ]]; then
    export SOPS_AGE_KEY_FILE="$HOME/.config/mise/age.txt"
    export MISE_SOPS_AGE_KEY_FILE="$HOME/.config/mise/age.txt"
fi

# Is in source_cache
# eval "$(mise activate zsh)"

alias mr="mise run"