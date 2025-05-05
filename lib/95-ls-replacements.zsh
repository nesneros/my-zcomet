if (( ${+commands[lsd]} )) ; then
    alias+ lsd -hA --group-dirs first 
fi

if (( ${+commands[eza]} )) ; then
    alias+ eza --git -a --icons --group-directories-first --ignore-glob=".git\|.DS_Store"
    # Change color of date column (da), git modified (gm) in long listings
    export EZA_COLORS="da=37:gm=31:di=36"
    alias ls=eza
fi
