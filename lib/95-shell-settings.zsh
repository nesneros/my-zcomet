# History environment variables
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=120000  # Larger than $SAVEHIST for HIST_EXPIRE_DUPS_FIRST to work
SAVEHIST=100000
HISTDUP=erase

setopt APPEND_HISTORY        # Add commands to history immediately, not waiting for shell exit
setopt EXTENDED_HISTORY       # Save time stamps and durations
setopt SHARE_HISTORY        # Constantly share history between shell instances
setopt HIST_FIND_NO_DUPS      # Do not display duplicates in history
setopt HIST_IGNORE_ALL_DUPS  # Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again

setopt AUTO_CD            # Change to a directory just by typing its name
setopt AUTO_PUSHD         # Make cd push each old directory onto the stack
setopt CDABLE_VARS        # Like AUTO_CD, but for named directories
setopt PUSHD_IGNORE_DUPS  # Don't push duplicates onto the stack

setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
setopt PATH_DIRS            # Perform path search even on command names with slashes.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB        # Needed for file modification glob modifiers with compinit.
unsetopt MENU_COMPLETE      # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL       # Disable start/stop characters in shell editor.

_insert-watch-at-beginning() {
  LBUFFER="watch $LBUFFER"
  zle reset-prompt  # Reset the prompt
}

# Bind a keyboard shortcut to the custom widget
zle -N _insert-watch-at-beginning
bindkey '^W^W' _insert-watch-at-beginning
