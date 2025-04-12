# Source this from your .zshrc file to load zcomet.

zmodload zsh/datetime
start_time="$EPOCHREALTIME"

0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

zstyle ':zcomet:compinit' dump-file $HOME/.cache/zcompdump_${EUID}_${OSTYPE}_${ZSH_VERSION}

# Setup MY_ZCOMET to point to this plugin
if [[ -z "$MY_ZCOMET" ]]; then
  MY_ZCOMET=${0:h:h}
elif [[ "$MY_ZCOMET" != "${0:h:h}" ]]; then
  echo "MY_ZCOMET mismatch: ${MY_ZCOMET} != ${0:h:h}"
  read && return 1
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

zcomet load "$MY_ZCOMET"

end_beforecompinit_time="$EPOCHREALTIME"

zcomet compinit

end_time="$EPOCHREALTIME"

printf "Startup time: %.0f ms (without compinit %.0f ms)\n" $(( 1000 * ( $end_time - $start_time ))) $(( 1000 * ( $end_beforecompinit_time - $start_time )))