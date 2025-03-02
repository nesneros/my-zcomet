hash oh-my-posh  &>/dev/null || return

OH_MY_POSH_THEME=powerlevel10k_modern

eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/$OH_MY_POSH_THEME.omp.json)" # --config $MY_ZCOMET/dotfiles/oh-my-posh/newline.json)"