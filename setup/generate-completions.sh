#!/usr/bin/env bash

set -euo pipefail

# Insert a ShellCheck disable after the first line so a leading #compdef stays first.
_insert-shellcheck() {
    local destFile=$1 codes=$2 tmp first
    [[ -n $codes ]] || return 0
    tmp=$(mktemp)
    {
        IFS= read -r first
        printf '%s\n' "$first"
        printf '# shellcheck disable=%s\n' "$codes"
        cat
    } <"$destFile" >"$tmp"
    mv "$tmp" "$destFile"
}

_gen-comp() {
    compSubCmd="${3:-completion}"
    cmd=$2
    destFile="$1/_$cmd"
    hash "$cmd" &>/dev/null || return 0
    $cmd "$compSubCmd" zsh >"$destFile"
    # Optional 4th arg: ShellCheck codes to disable.
    _insert-shellcheck "$destFile" "${4:-}"
}

_carapace-gen() {
    cmd=$2
    destFile="$1/_$cmd"
    hash carapace &>/dev/null || return 0
    hash "$cmd" &>/dev/null || return 0
    carapace "$cmd" zsh >"$destFile"
    _insert-shellcheck "$destFile" SC2124,SC2154,SC2034
}

destDir="$MY_ZCOMET/generated/functions"
mkdir -p "$destDir"
_carapace-gen "$destDir" carapace	
# _gen-comp "$destDir" golangci-lint
_gen-comp "$destDir" jira
_gen-comp "$destDir" k3d
_gen-comp "$destDir" kubectl completion SC1087,SC2034,SC2068,SC2076,SC2086,SC2128,SC2141,SC2154,SC2155,SC2164,SC2193
_gen-comp "$destDir" mise
_gen-comp "$destDir" mole
_carapace-gen "$destDir" ollama
_gen-comp "$destDir" orbctl
_gen-comp "$destDir" ov --completion SC1087,SC2034,SC2068,SC2076,SC2086,SC2128,SC2141,SC2154,SC2155,SC2164,SC2193
_carapace-gen "$destDir" ykman
# _gen-comp "$destDir" usage --completions
