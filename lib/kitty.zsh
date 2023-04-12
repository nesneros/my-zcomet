if (( ! ${+commands[kitty]} )); then
  return
fi

alias icat="kitty +kitten icat"
alias kitty-close-other-tabs="for id in \$(kitty @ ls | jq '.[0].tabs | .[] | select(.is_focused == false) | .id'); do kitty @ close-tab --match=id:\$id; done"