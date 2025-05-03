hash shellfirm &>/dev/null || return

function shellfirm-pre-command () {
    if [[ "${1}" == *"shellfirm pre-command"* ]]; then
        return
    fi
    shellfirm pre-command --command "${1}"
}

autoload -Uz add-zsh-hook

add-zsh-hook preexec shellfirm-pre-command