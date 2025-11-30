#!/usr/bin/env bash

set -e

_gen-comp() {
    compSubCmd="${3:-completion}"
    cmd=$2
    destFile="$1/_$cmd"
    hash "$cmd" &>/dev/null || return 0
    $cmd "$compSubCmd" zsh >"$destFile"
}

destDir="$MY_ZCOMET/generated/functions"
mkdir -p "$destDir"
_gen-comp "$destDir" golangci-lint
_gen-comp "$destDir" jira
_gen-comp "$destDir" kubectl
_gen-comp "$destDir" orbctl
_gen-comp "$destDir" ov --completion
hash ykman &>/dev/null && _YKMAN_COMPLETE=bash_source ykman completion zsh > "$destDir/_ykman"
# _gen-comp "$destDir" usage --completions
