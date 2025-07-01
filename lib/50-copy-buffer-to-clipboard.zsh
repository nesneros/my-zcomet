copy_buffer_to_clipboard() {
    printf "%s" "$BUFFER" | clip
}

zle -N copy_buffer_to_clipboard

bindkey -M emacs "^O" copy_buffer_to_clipboard
bindkey -M viins "^O" copy_buffer_to_clipboard
bindkey -M vicmd "^O" copy_buffer_to_clipboard
