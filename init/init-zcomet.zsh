# Source this from your .zshrc file to load zcomet.
# If zcomet is not installed it will be cloned.
# Then continue to load this as a zcomet plugin

zmodload zsh/datetime
start_time="$EPOCHREALTIME"

0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

zstyle ':zcomet:compinit' dump-file $HOME/.cache/zcompdump_${EUID}_${OSTYPE}_${ZSH_VERSION}

# Setup MY_ZCOMET to point to this plugin
if [[ -z "$MY_ZCOMET" ]]; then
  MY_ZCOMET=${0:h:h}
elif [[ "$MY_ZCOMET" != "${0:h:h}" ]]; then
  echo "MY_ZCOMET mismatch: ${MY_ZCOMET} != ${0:h:h}"
  read && return 1
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

zcomet load "$MY_ZCOMET"

# Remove duplicates and non-existant directories from misc paths 
# This should not be done before the zcomet plugin is completely loaded
cleanup-path() {
  local var_name=$1
  local var_value
  
  # Get the value of the variable
  var_value=${(P)var_name}
  
  if [[ -z "$var_value" ]]; then
    echo "Error: Variable $var_name not found or empty."
    return 1
  fi
  
  # Split the path into an array using colon as separator
  local path_array=(${(s/:/)var_value})
  local new_path=()
  local cleaned_path=""
  
  # Process each directory in the path
  for dir in "${path_array[@]}"; do
    # Check if the directory exists and is not already in our new path
    if [[ -d "$dir" && ! "${new_path[(ie)$dir]}" -le "${#new_path}" ]]; then
      new_path+=("$dir")
    fi
  done
  
  # Join the array elements with colons for the output
  cleaned_path="${(j/:/)new_path}"

 # Assign new value
  eval "export $var_name=$cleaned_path"
}

cleanup-path PATH
cleanup-path FPATH
cleanup-path MANPATH

end_beforecompinit_time="$EPOCHREALTIME"

zcomet compinit

end_time="$EPOCHREALTIME"

printf "Startup time: %.0f ms (without compinit %.0f ms)\n" $(( 1000 * ( $end_time - $start_time ))) $(( 1000 * ( $end_beforecompinit_time - $start_time )))