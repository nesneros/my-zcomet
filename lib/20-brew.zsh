if [[ -z "$HOMEBREW_PREFIX" ]] ; then
  local brewBins=({/opt/homebrew,/usr/local,/home/linuxbrew/.linuxbrew}/bin/brew(.N))
  local brewBin=${brewBins[1]}
  if [[ -x "$brewBin" ]] ; then
    eval $($brewBin shellenv)
  fi
fi

if (( ${+commands[brew]} )) ; then
  [[ -z "$HOMEBREW_PREFIX" ]] && echo "HOMEBREW_PREFIX not defined"
  FPATH=${HOMEBREW_PREFIX}/share/zsh/site-functions:$FPATH
fi
