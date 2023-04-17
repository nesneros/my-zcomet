(( ${+commands[lab]} )) || return

export LAB_CORE_HOST="https://gitlab.com"
lab() {
    token=$(api-token gitlab)
    if [ -z "$token" ]; then
        command lab "$@"
    else
        LAB_CORE_TOKEN=$token command lab "$@"
    fi
}
