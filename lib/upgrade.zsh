_asdf_latest() {
    name=$1
    asdf plugin-add $name >/dev/null 2>&1
    if asdf install $name latest | grep -v "is already installed$"; then
        echo "asdf: NEW VERSION OF $name INSTALLED"
        asdf list $name
    fi
}

upgrade-all() {
    if hash apt-get &>/dev/null; then
        print "\n--- Upgrading APT packages ---"
        sudo apt-get update && sudo apt-get upgrade
    fi

    if hash brew &>/dev/null; then
        print "\n--- Upgrading brews ---"
        # brew upgrade --cask --greedy
        brew upgrade --cask
        brew upgrade
        brew cleanup
    fi

    if hash asdf >/dev/null; then
        print "\n--- Upgrading asdf plugins ---"
        asdf plugin-update --all | grep -v "Already on '\|Your branch is up to date with"

        _asdf_latest golang
        # _asdf_latest direnv
    fi

    if hash kubectl &>/dev/null && [ -d $HOME/.krew/bin ]; then
        print "\n--- Upgrading kubectl krew ---"
        kubectl krew upgrade 2>&1 | grep -v "it is already on the newest version$"
    fi

    print "\n--- Upgrade zcomet ---"
    type zcomet &>/dev/null && zcomet update

    print "\n--- Upgrade completions ---"
    upgrade-completions

    exec zsh
}

upgrade-completions() {
    destDir=/usr/local/share/zsh/site-functions

    _gen-comp $destDir kubectl-krew
    _gen-comp $destDir jira
    _gen-comp $destDir kubectl
}

_gen-comp() {
    cmd=$2
    destFile="$1/_$cmd"
    if (( ${+commands[$cmd]} )) ; then
        echo "Generating completion for $cmd to $destFile"
        $cmd completion zsh > "$destFile"
    fi
}