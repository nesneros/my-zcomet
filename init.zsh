# Make the ZCOMET_SOURCE variable available to all scripts so it can be sourced to make zcomet available
export ZCOMET_SOURCE=$ZCOMET[SCRIPT]
export MY_ZCOMET
export PATH=$MY_ZCOMET/bin:$HOME/share/bin:$HOME/bin:$PATH
export FPATH=$MY_ZCOMET/generated/generated:$FPATH

autoload -Uz $MY_ZCOMET/autoloads/*

func alias+() {
    alias "$1"="${aliases[$1]:-$1} $argv[2,-1]"
}

# Load lib folder

zcomet load agkozak/zsh-z
for config_file ($MY_ZCOMET/lib/*.zsh); do
    # echo "Loading $config_file..."
    [[ $PROFILING ]] && local start_time=$EPOCHREALTIME
    source $config_file
    [[ $PROFILING ]] && local end_time=$EPOCHREALTIME
    [[ $PROFILING ]] && printf "%3.f : $config_file\n" $(( 1000 * ( $end_time - $start_time )  ))
done

unset config_file
