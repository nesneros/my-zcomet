(( ${+commands[jira]} )) || return

if tmp=$(api-token jira 2> /dev/null) ; then
    export JIRA_API_TOKEN=$tmp
fi

jira() {
    if [ -z "$JIRA_PROJECT" ]; then
        command jira "$@"
    else 
        command jira --project "$JIRA_PROJECT" "$@"
    fi
}

alias j=jira

alias jmyopen='jira issue list -a$(command jira me) --order-by rank --reverse -s~done'
alias jmyopen-select='jira issue list -a$(command jira me) --order-by rank -s~done | fzf --tac | awk "{ print \$2 }" '

_jira_issue_id() {
    id=$1
    if [[ -z "$id" ]]; then
        currentBranchName=$(git branch --show-current) || return 1
        id=$(git config --get "branch.$currentBranchName.commitScope")
    fi
    if [[ -z "$id" ]]; then
        echo "No Jira issue id found" > /dev/stderr
        return 1
    fi
    echo $id
}

jopen() {
    jira open $(_jira_issue_id $1)
}

jira-summary() {
    id=$(_jira_issue_id $1) || return 1
    jira issue view $id | grep '^  #' | sed 's/^  # *//'
}
