hash mise &>/dev/null || return

eval "$(mise activate zsh)"

export SOPS_AGE_KEY_FILE="$HOME/.config/mise/age.txt"