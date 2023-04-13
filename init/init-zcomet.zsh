if [[ -z "$MY_ZCOMET" ]]; then
  MY_ZCOMET=$(cd $(dirname $0)/.. ; pwd)
fi
export MY_ZCOMET

if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

zcomet load "$MY_ZCOMET"
