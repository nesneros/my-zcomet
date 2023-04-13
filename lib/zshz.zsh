export ZSHZ_SOURCE
whence -v zshz | sed 's/zshz is a shell function from //' | read ZSHZ_SOURCE

[[ $pipestatus[1] == 0 ]] || unset ZSHZ_SOURCE
