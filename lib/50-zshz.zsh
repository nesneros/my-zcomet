# zsh-z: Define env var with the source to source to get the zshz function
zcomet load agkozak/zsh-z
export ZSHZ_SOURCE
whence -v zshz | sed 's/zshz is a shell function from //' | read ZSHZ_SOURCE
