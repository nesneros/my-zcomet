# compleo is managed by mise, so this must after mise is activated, hence 55 in name.
hash compleo &>/dev/null || return

eval "$(compleo activate)"