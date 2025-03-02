# Enable instant prompt for p10k
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

zcomet load romkatv/powerlevel10k  . powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
P10K_FILE=$MY_ZCOMET/dotfiles/p10k.zsh
[[ ! -f "$P10K_FILE" ]] || source "$P10K_FILE"
unset P10K_FILE