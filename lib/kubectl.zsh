(( $+commands[kubectl] )) || return
    
alias kc=kubectl

if [ -d $HOME/.krew/bin ] ; then
    export PATH="${HOME}/.krew/bin:$PATH"
fi
