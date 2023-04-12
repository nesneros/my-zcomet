# Sourced during login

#echo "LOGIN $(date) - ${OSTYPE} - ${MY_ZCOMET}" >> /tmp/login.log

# Set env vars that will be be set when launching apps on macos
setenv() {
    if [ -z "$2" ]; then
        echo "Usage: setenv <name> <value>"
    else
#        if [ "$OSTYPE" == darwin* ]; then
            launchctl setenv "$1" "$2"
#        fi
        export $1="$2"
    fi
}

setenv MY_ZCOMET $MY_ZCOMET
setenv KITTY_CONFIG_DIRECTORY "$MY_ZCOMET/dotfiles/kitty"
