# Make the ZCOMET_SOURCE variable available to all scripts so it can be sourced to make zcomet available
export ZCOMET_SOURCE=$ZCOMET[SCRIPT]
export MY_ZCOMET
export PATH=$MY_ZCOMET/bin:$HOME/share/bin:$HOME/bin:$PATH
export FPATH=$MY_ZCOMET/generated/functions:$FPATH

autoload -Uz $MY_ZCOMET/autoloads/*

func alias+() {
    alias "$1"="${aliases[$1]:-$1} $argv[2,-1]"
}

# Load lib folder

for config_file ($MY_ZCOMET/lib/*.zsh); do
    # echo "Loading $config_file..."
    [[ $PROFILING ]] && local start_time=$EPOCHREALTIME
    source $config_file
    [[ $PROFILING ]] && local end_time=$EPOCHREALTIME
    [[ $PROFILING ]] && printf "%3.f : $config_file\n" $(( 1000 * ( $end_time - $start_time )  ))
done

unset config_file

# Remove duplicates and non-existant directories from misc paths 
# This should not be done before the zcomet plugin is completely loaded
cleanup-path() {
  local var_name=$1
  local var_value
  
  # Get the value of the variable
  var_value=${(P)var_name}
  
  if [[ -z "$var_value" ]]; then
    # echo "Error: Variable $var_name not found or empty."
    return 0
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
