# Make a few vim like key bindings
bindkey "^j" down-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search

return 

zcomet load ohmyzsh plugins/vi-mode

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
