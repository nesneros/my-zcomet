(( $+commands[kubectl] )) || return
    
alias kc=kubectl
export PATH="${HOME}/.krew/bin:$PATH"
