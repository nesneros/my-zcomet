export MY_ZCOMET=$HOME/my-zcomet

export POWERLEVEL9K_INSTANT_PROMPT=verbose

# Enable instant prompt for p10k
# (( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# (( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

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

export ZSH_THEME="powerlevel10k/powerlevel10k"

_load_omz_plugin() {
  local pluginName="$1"
  zcomet load "ohmyzsh/ohmyzsh" "plugins/$pluginName" "$pluginName.plugin.zsh"
}

zcomet load agkozak/zsh-z
zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh

_load_omz_plugin dirhistory
_load_omz_plugin macos
_load_omz_plugin web-search

# It is good to load these popular plugins last, and in this order:
zcomet load Aloxaf/fzf-tab
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-completions . zsh-completions.plugin.zsh
# zcomet load zsh-users/zsh-autosuggestions

# Include some standard functionality form OMZ
zcomet load ohmyzsh/ohmyzsh lib completion.zsh directories.zsh functions.zsh history.zsh key-bindings.zsh misc.zsh

zcomet load $MY_ZCOMET

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

# gor alias is define for golang plugin. Redefined it here to use parsepanic
if typeset -f gorunpp >/dev/null; then
    alias gor=gorunpp
fi

# Remove duplicates from PATH
typeset -U path

# Remove non-existing dirs from path
valid_dirs=()
for dir in $path; do
    [[ -d $dir ]] && valid_dirs+=($dir)
done
path=("${valid_dirs[@]}")

# autoload -U compinit && compinit
# Define some aliases. Note gr overrides a git alias
# alias gr=gradle

unsetopt correctall
