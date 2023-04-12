if (( $+commands[codium] )) ; then
    export VEDITOR=$(which codium)
    export EDITOR="$VEDITOR -w"
elif (( $+commands[code] )) ; then
    export VEDITOR=$(which code)
    export EDITOR="$VEDITOR -w"
fi
