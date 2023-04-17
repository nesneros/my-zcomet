(( ${+commands[glab]} )) || return

glab() {
    token=$(api-token gitlab)
    if [ -z "$token" ]; then
        command glab "$@"
    else
        GITLAB_TOKEN=$token command glab "$@"
    fi
}

alias glab-mr-create='glab mr create --web --title "$(git cc-prefix)$(jira-summary)" --description " "'
alias glab-mr-list='glab mr list --state=opened --author=me --sort=updated_at --order=desc'