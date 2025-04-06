(( $+commands[kubectl] )) || return
    
alias k=kubectl

# End of setup path will be cleaned up so just add to path without check
export PATH="${HOME}/.krew/bin:$PATH"
