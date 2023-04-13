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

# Inspired by Zoppo
# Create an alias for a command with some options.
# Either create new alias or add options to existing alias
alias+() {
    alias "$1"="${aliases[$1]:-$1} $argv[2,-1]"
}

zcomet load agkozak/zsh-z

_load_omz_plugin() {
  local pluginName="$1"
  zcomet load "ohmyzsh/ohmyzsh" "plugins/$pluginName" "$pluginName.plugin.zsh"
}

_load_omz_plugin dirhistory
_load_omz_plugin macos
_load_omz_plugin web-search

# Include some standard functionality form OMZ
zcomet load ohmyzsh/ohmyzsh lib completion.zsh directories.zsh functions.zsh history.zsh key-bindings.zsh misc.zsh

# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh(N)); do
    source $config_file
done
unset config_file

zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh

# It is good to load these popular plugins last, and in this order:
zcomet load Aloxaf/fzf-tab
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-completions . zsh-completions.plugin.zsh
# zcomet load zsh-users/zsh-autosuggestions

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

# Convenient function to create a dir and cd into it
function mcd {
    mkdir -p $1
    cd $1
}

# Remove non-existing dirs from path
valid_dirs=()
for dir in $path; do
    [[ -d $dir ]] && valid_dirs+=($dir)
done
path=("${valid_dirs[@]}")


# Autoload 
autoload -Uz upgradeall

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
