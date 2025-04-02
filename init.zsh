# Make the ZCOMET_SOURCE variable available to all scripts so it can be sourced to make zcomet available
export ZCOMET_SOURCE=$ZCOMET[SCRIPT]
export MY_ZCOMET
export PATH=$MY_ZCOMET/bin:$HOME/share/bin:$HOME/bin:$PATH
export FPATH=$MY_ZCOMET/functions/generated:$FPATH

autoload -Uz $MY_ZCOMET/autoloads/*

# Load lib folder

zcomet load agkozak/zsh-z
for config_file ($MY_ZCOMET/lib/*.zsh); do
    # echo "Loading $config_file..."
    # start_time=$EPOCHREALTIME
    source $config_file
    # echo "$EPOCHREALTIME - $start_time" | bc
done
unset config_file
