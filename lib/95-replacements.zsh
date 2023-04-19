if (( ${+commands[lsd]} )) ; then
    alias+ lsd -hA --group-dirs first 
fi

if (( ${+commands[exa]} )) ; then
    alias+ exa --git -a --icons --group-directories-first --ignore-glob=".git\|.DS_Store"
    # Change color of date column (da), git modified (gm) in long listings
    export EXA_COLORS="da=37:gm=31:di=36"
    alias ls=exa
fi
