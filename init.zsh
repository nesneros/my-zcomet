# Enable instant prompt for p10k
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# Load brew if install
if [[ -z "$HOMEBREW_PREFIX" ]] ; then
  brewLocations=(/opt/homebrew /usr/local /home/linuxbrew/.linuxbrew)
  for e in $brewLocations; do
    brewBin=$e/bin/brew
    if [[ -x "$brewBin" ]] ; then
      eval $($brewBin shellenv)
      break
    fi
    unset brewBin
  done
  unset brewLocations
fi

if (( ${+commands[brew]} )) ; then
  [[ -z "$HOMEBREW_PREFIX" ]] && echo "HOMEBREW_PREFIX not defined"
  FPATH=${HOMEBREW_PREFIX}/share/zsh/site-functions:$FPATH
fi

# zsh-z: Define env var with the source to source to get the zshz function
zcomet load agkozak/zsh-z
export ZSHZ_SOURCE
whence -v zshz | sed 's/zshz is a shell function from //' | read ZSHZ_SOURCE

# Include some standard functionality form OMZ
zcomet load ohmyzsh/ohmyzsh lib completion.zsh directories.zsh functions.zsh history.zsh key-bindings.zsh misc.zsh

# Load some OMZ plugins
zcomet load ohmyzsh plugins/dirhistory
zcomet load ohmyzsh plugins/macos

autoload -Uz $MY_ZCOMET/functions/*

# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh(N)); do
    source $config_file
done
unset config_file

zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh

# It is good to load these popular plugins last, and in this order:
zcomet load Aloxaf/fzf-tab

# Some stuff from zsh-users
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-completions
zcomet load zsh-users/zsh-history-substring-search 
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# zcomet load zsh-users/zsh-autosuggestions

zcomet trigger --no-submodules archive unarchive lsarchive prezto modules/archive

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

# Remove non-existing dirs from path
valid_dirs=()
for dir in $path; do
    [[ -d $dir ]] && valid_dirs+=($dir)
done
path=("${valid_dirs[@]}")

zcomet compinit

# Create aliases that changes system commands after compinit

alias ll="ls -l"
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

alias myip='echo $(curl -s http://whatismyip.akamai.com/)'
# alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Disable glob for some commands
for e in find fd mdfind rsync scp; do
    alias "$e=noglob ${aliases[$e]:-$e}"
done

# Disable correction for some commands
for e in ag cp grep ln mv; do
    alias "$e=nocorrect ${aliases[$e]:-$e}"
done
