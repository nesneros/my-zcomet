if (( ! ${+commands[zoxide]} )); then
  return
fi

export _ZO_DATA_DIR="$HOME/.local/share/zoxide"

eval "$(zoxide init zsh)"

alias z-list='zoxide query --list --score'

