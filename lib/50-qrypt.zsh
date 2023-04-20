local dirs=({$HOME,$HOME/Documents}/.qrypt(/N))
[[ -z "$dirs" ]] || export QRYPT_DIR="$dirs[1]"
