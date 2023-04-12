alias ll=ls -l
alias week="date +%V"

alias+ pgrep -fli
alias+ df -h

# Some global aliases
alias -g B='| bat'
alias -g F='| less +F'
alias -g GREP='| grep --ignore-case -E'
alias -g G='| rg --smart-case'
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail -100f'
alias -g P='| peco'
alias -g Z='| fzf --tac'
# Colorize json
alias -g J='|jq .'

# Disable glob for some commands
for e in find fd mdfind rsync scp; do
    alias "$e=noglob ${aliases[$e]:-$e}"
done

# Disable correction for some commands
for e in ag cp grep ln mv; do
    alias "$e=nocorrect ${aliases[$e]:-$e}"
done

alias myip='echo $(curl -s http://whatismyip.akamai.com/)'
# alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

