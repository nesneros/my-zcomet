if (( ! ${+commands[lesspipe.sh]} )); then
  return
fi

eval $(lesspipe.sh 2> /dev/null)
