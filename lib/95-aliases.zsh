function _makesudo {
    if type "$1" >/dev/null; then
        alias "$1"="sudo $1"
    fi
}

# Always use sudo with a few commands
case "$OSTYPE" in
linux*)
    for p in apt aptitude snap systemctl; do
        _makesudo $p
    done
    ;;
darvin*) ;;
*) ;;
esac

# Create aliases that changes system commands after compinit
alias ll="ls -l"
alias week="date +%V"
alias c=cat

alias+ pgrep -fli
alias+ df -h

# Some global aliases
alias -g B='| bat'
alias -g F='| less +F'
alias -g GREP='| grep --ignore-case -E'
alias -g G='| rg --smart-case'
alias -g GG='| rg -C1 --smart-case'
alias -g GGG='| rg -C2 --smart-case'
alias -g GGGG='| rg -C3 --smart-case'
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail -100f'
alias -g P='| peco'
alias -g Z='| fzf --tac'
# Colorize json
alias -g J='|jq .'

# Aliases based on suffix
alias -s md=mdcat
alias -s txt=cat
alias -s pdf="pdfgrep ."

alias myip='echo $(curl -s http://whatismyip.akamai.com/)'
# alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

alias geo="curl -s https://ipinfo.io | jq -r '. | {ip, org, city, postal, region, country, loc, timezone} | to_entries[] | [.key, .value] | @tsv ' | column -t -s $'\t'"

# Disable glob for some commands
for e in find fd mdfind rsync scp; do
    alias "$e=noglob ${aliases[$e]:-$e}"
done

# Disable correction for some commands
for e in ag cp grep ln mv; do
    alias "$e=nocorrect ${aliases[$e]:-$e}"
done

alias tor="tor -f $HOME/.tor/torrc --Log 'notice stdout'"