if tmp=$(api-token github 2> /dev/null) ; then
    export GITHUB_TOKEN=$tmp
fi

if (( ${+commands[gh]} )); then
    # eval $(gh completion -s zsh)
    alias gh_auth="api-token github | gh auth login --with-token && gh auth status"
fi

if (( ${+commands[hub]} )); then
    alias g=hub
else 
    alias g=git
fi
