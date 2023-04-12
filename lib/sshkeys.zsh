# Return if not on macOS
[[ "$OSTYPE" != darwin* ]] && return

if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
    ssh-add -q --apple-use-keychain ~/.ssh/id_ed25519
fi
