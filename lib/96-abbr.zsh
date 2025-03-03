# Only works if zsh-abbr is installed with brew
abbrfile="$HOMEBREW_PREFIX/share/zsh-abbr/zsh-abbr.zsh"
[[ -f "$abbrfile" ]] || return
source "$abbrfile"

_alias_to_abbr() {
    name="$1"
    if x=$(alias "$name") ; then
        eval "$(echo "$x" | sed 's/^/abbr --session /')" > /dev/null
    fi
}

_alias_to_abbr c
_alias_to_abbr df
_alias_to_abbr g
_alias_to_abbr k
_alias_to_abbr kc

# If zsh-z exists as function create an abbr to it
# if whence -v zshz > /dev/null ; then
#     abbr --session ,="zshz" > /dev/null
# fi

abbr --session "git p"="git pull" > /dev/null
abbr --session "git c"="git checkout" > /dev/null
abbr --session "git checkout m"="git checkout master" > /dev/null
abbr --session "git w"="git wt-setup" > /dev/null
abbr --session "git r"="git wt-setup --remove" > /dev/null

