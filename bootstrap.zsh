# Source this from your .zshrc file to load zcomet
# an this plugin.
# Note naming of this file and init.zsh is important. zcomet uses naming convention 
# to unit init.zsh to init the plugin

0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if [[ -z "$MY_ZCOMET" ]]; then
  MY_ZCOMET=${0:h}
elif [[ "$MY_ZCOMET" != "${0:h}" ]]; then
  echo "MY_ZCOMET mis match: ${MY_ZCOMET} != ${0:h}"
  read && return 1
fi

if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Make the ZCOMET_SOURCE variable available to all scripts so it can be sourced to make zcomet available
export ZCOMET_SOURCE=$ZCOMET[SCRIPT]
export MY_ZCOMET

zcomet load "$MY_ZCOMET"
