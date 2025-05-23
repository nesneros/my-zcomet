# Remove all .zwc files (compiled zsh files)
clean-zwc() {
    fd --no-ignore-vcs --glob "*.zwc" | xargs rm
}

# from http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
imv() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}

# Convenient function to create a dir and cd into it
mcd() {
    mkdir -p "$1"
    cd "$1"
}
