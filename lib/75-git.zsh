# Completion for git extras
if (( ${+commands[git-extras]} )) ; then
    zcomet snippet https://github.com/tj/git-extras/blob/master/etc/git-extras-completion.zsh
fi

# glab to interact with Gitlab
if (( ${+commands[glab]} )) ; then
    # local token=$(api-token gitlab)
    # $? != 0 || return

    glab() {
        token=$(api-token -q gitlab)
        if [ -z "$token" ]; then
            command glab "$@"
        else
            GITLAB_TOKEN=$token command glab "$@"
        fi
    }

    alias glab-mr-create='glab mr create --web --title "$(git cc-prefix)$(jira-summary)" --description " "'
    alias glab-mr-list='glab mr list --state=opened --author=me --sort=updated_at --order=desc'
fi

# Used by hub (and maybe others)
if tmp=$(api-token github 2> /dev/null) ; then
    export GITHUB_TOKEN=$tmp
fi

if (( ${+commands[gh]} )); then
    # eval $(gh completion -s zsh)
    alias gh_auth="api-token github | gh auth login --with-token && gh auth status"
fi

alias g=git