[[ "$OSTYPE" = 'darwin*' ]] && return

# https://iterm2.com/documentation-escape-codes.html

it2prof() {
    echo -e "\033]50;SetProfile=$1\a"
}

it2takeFocus() {
    _it2control "1337;StealFocus"
}
it2setBg() {
    _it2setColor -2 $1 $2 $3
}

_it2setColor() {
    local bgOrFg=$1
    shift
    local red=$1
    shift
    local green=$1
    shift
    local blue=$1
    shift
    _it2control "4;$bgOrFg;rgb:$red/$green/$blue"
}

_it2control() {
    echo -e "\033]$1\a"
}

# Iterm2 shell integration can be installed from the iterm2 menu. 
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
    source "$HOME/.iterm2_shell_integration.zsh"
fi
