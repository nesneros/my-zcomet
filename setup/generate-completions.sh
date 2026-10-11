#!/usr/bin/env bash

set -euo pipefail

_gen-comp() {
    compSubCmd="${3:-completion}"
    cmd=$2
    destFile="$1/_$cmd"
    hash "$cmd" &>/dev/null || return 0
    $cmd "$compSubCmd" zsh >"$destFile"
    # Optional 4th arg: ShellCheck codes to disable. Inserted after the first
    # line so a leading #compdef stays first for zsh.
    if [[ -n ${4:-} ]]; then
        local tmp first
        tmp=$(mktemp)
        {
            IFS= read -r first
            printf '%s\n' "$first"
            printf '# shellcheck disable=%s\n' "$4"
            cat
        } <"$destFile" >"$tmp"
        mv "$tmp" "$destFile"
    fi
}

destDir="$MY_ZCOMET/generated/functions"
mkdir -p "$destDir"
# _gen-comp "$destDir" golangci-lint
_gen-comp "$destDir" jira
_gen-comp "$destDir" k3d
_gen-comp "$destDir" kubectl completion SC1087,SC2034,SC2068,SC2076,SC2086,SC2128,SC2141,SC2154,SC2155,SC2164,SC2193
_gen-comp "$destDir" mise
_gen-comp "$destDir" mole
_gen-comp "$destDir" orbctl
_gen-comp "$destDir" ov --completion SC1087,SC2034,SC2068,SC2076,SC2086,SC2128,SC2141,SC2154,SC2155,SC2164,SC2193
if hash ykman &>/dev/null; then
    _YKMAN_COMPLETE=bash_source ykman completion zsh >"$destDir/_ykman"
    tmp=$(mktemp)
    {
        printf '%s\n' '# shellcheck disable=SC2086,SC2162,SC2206'
        cat "$destDir/_ykman"
    } >"$tmp"
    mv "$tmp" "$destDir/_ykman"
fi
# _gen-comp "$destDir" usage --completions
