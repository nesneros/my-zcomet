if (( ! ${+commands[kitty]} )); then
  return
fi

alias icat="kitty +kitten icat"
alias kt-close-other-tabs="for id in \$(kitty @ ls | jq '.[0].tabs | .[] | select(.is_focused == false) | .id'); do kitty @ close-tab --match=id:\$id; done"

# Some alias to work with multiple Kitty windows
alias kt-tab-cd="kitty-send --command tab cd
alias kt-window-cd="kitty-send --command osWindow cd
alias kt-tab-pwd-cd="kitty-send --command --skip-me tab cd \$(pwd)"
alias kt-window-pwd-cd="kitty-send --command --skip-me osWindow cd \$(pwd)"
