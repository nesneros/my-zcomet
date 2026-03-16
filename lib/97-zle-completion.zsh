_expand-abbrev() {
    local lastword="${LBUFFER##* }"
    lastword="${lastword#\'}"
    lastword="${lastword#\"}"
    lastword="${lastword#*=}"
    local op=""
    case "$lastword" in
    .*)
        if git rev-parse --git-dir >/dev/null 2>&1; then
            case "$lastword" in
            ".b") op="git-branch" ;;
            ".c") op="git-commit" ;;
            ".d") op="git-dirty" ;;
            ".f") op="git-file" ;;
            ".w") op="git-worktrees" ;;
            esac
        fi
        ;;
    ,*)
        if whence -v zshz >/dev/null; then
            op="zshz"
        fi
        ;;
    esac

    if [[ -z "$op" ]]; then
        zle "$_fallback_widget"
    else
        local result=""
        case "$op" in
        "git-commit") result=$(git log --oneline --topo-order --decorate -n100 | fzf --exit-0 --select-1 --multi --reverse | cut -d' ' -f1) ;;
        "git-dirty")
            local gitroot=$(git root)
            # this is kinda hairy... the perl mess gives you a nice relative path
            # so you can use this with git add, and you don't have to deal with
            # an absolute path since usually you don't need to
            result=$(
                git -C "$gitroot" ls-files --exclude-standard --modified --others |
                    fzf --exit-0 --select-1 --height 6 --reverse --multi |
                    perl -e 'use File::Spec; while(<STDIN>) { print(File::Spec->abs2rel(File::Spec->catfile($ARGV[0], $_))); }' -- "$gitroot"
            )
            ;;
        "git-branch") result=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | fzf --exit-0 --multi --select-1) ;;
        "git-file") result=$(rg --files | fzf --exit-0 --multi) ;;
        "zshz")
            rest="${lastword:1}"
            result=$(zshz -l "$rest" | fzf --exit-0 --select-1 --multi --tac --reverse | awk '{ print $2 }' )
            ;;
        esac
        replacement=""
        while IFS= read -r line; do
            escaped=$(printf '%q' "$line")
            if [[ ! -z "$replacement" ]]; then
                replacement="$replacement "
            fi
            replacement="$replacement$escaped"
        done <<<"$result"
        LBUFFER="${LBUFFER%"$lastword"}$replacement"
        zle redisplay
    fi
}

# Get widget to fallback to if we don't have anything to expand
_fallback_widget="${${$(builtin bindkey '^I')##* }:-expand-or-complete}"
zle -N _expand-abbrev
bindkey "^I" _expand-abbrev
