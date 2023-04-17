# Source this from your .zshrc file to load zcomet.
# If zcomet is not installed it will be cloned.
# Then continue to load this as a zcomet plugin

0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Setup MY_ZCOMET to point to this plugin
if [[ -z "$MY_ZCOMET" ]]; then
  MY_ZCOMET=${0:h:h}
elif [[ "$MY_ZCOMET" != "${0:h:h}" ]]; then
  echo "MY_ZCOMET mismatch: ${MY_ZCOMET} != ${0:h:h}"
  read && return 1
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

zcomet load "$MY_ZCOMET"
