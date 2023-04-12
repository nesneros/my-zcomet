searchDirs=($HOME $HOME/Documents)
for dir in $searchDirs; do
  if [ -d "$dir" ] ; then
    [ -z "$QRYPT_DIR" ] && [ -d "$dir/.qrypt" ] && export QRYPT_DIR="$dir/.qrypt"
  fi
done
