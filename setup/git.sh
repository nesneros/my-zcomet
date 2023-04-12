#! /usr/bin/env bash

set +e

gc() {
    git config --global "$1" "$2"
}

alias() {
    gc "alias.$1" "$2"
}

if hash delta >/dev/null; then
    gc pager.diff delta
    gc pager.show delta
    gc pager.log delta
    gc pager.blame delta
    gc pager.reflog delta
    gc interactive.diffFilter delta --color-only

    gc delta.features decorations
    gc delta.line-numbers true
    gc delta.side-by-side false
    gc delta.interactive.keep-plus-minus-markers false
fi

gc color.ui auto
gc core.pager cat
gc core.hooksPath $MY_ZCOMET/githooks
gc fetch.prune true

alias aliases "!git config --get-regexp alias | sed -re 's/^alias\.([a-z-]+) /\1:\t/g' | column -t -s $'\t'"
alias s "status --short"
alias lg "log --graph --date=relative --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset'"
alias wt "worktree"

alias hide "update-index --assume-unchanged"
alias hide-all "!git diff --name-only | xargs git hide"
alias unhide "update-index --no-assume-unchanged"
alias hidden "!git ls-files -v | grep '^[[:lower:]]' | cut -c 3-"
alias unhide-all "!git hidden | xargs git update-index --no-assume-unchanged"

#git config --global mergetool.smerge.cmd 'smerge mergetool "$BASE" "$LOCAL" "$REMOTE" -o "$MERGED"'
#git config --global mergetool.smerge.trustExitCode true
#git config --global merge.tool smerge
