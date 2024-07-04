# Make the ZCOMET_SOURCE variable available to all scripts so it can be sourced to make zcomet available
export ZCOMET_SOURCE=$ZCOMET[SCRIPT]
export MY_ZCOMET
export PATH=$MY_ZCOMET/bin:$PATH
export FPATH=$MY_ZCOMET/functions/generated:$FPATH

echo BOOM
autoload -Uz $MY_ZCOMET/autoloads/*

# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh); do
    source $config_file
done
unset config_file
