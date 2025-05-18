export VEDITOR=$(which e)
export EDITOR="$VEDITOR -w"
export GIT_EDITOR="$EDITOR"

if (( $+commands[ov] )) ; then
    export PAGER=$(which ov)
fi