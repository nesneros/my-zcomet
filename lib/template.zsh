# Check if 'requiredCommand' is available
# For more info see https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh
hash requiredCommand &>/dev/null || return
#hash ls &>/dev/null || return

# Do the stuff with requiredCommand
case $OSTYPE in
darwin*)
    echo "Darwin"
    echo "HOMEBREW_PREFIX=$HOMEBREW_PREFIX"
    brewName=wget
    abcPrefix=$(brew --prefix ${brewName})
    if [[ $? == 0 ]]; then
        echo "Brew prefix for $brewName: $abcPrefix"
    else
        echo "Brew $brewName not installed"
    fi
    unset brewName abcPrefix
    ;;
linux*)
    echo linux
    ;;
esac
