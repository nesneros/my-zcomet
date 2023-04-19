# Make the ZCOMET_SOURCE variable available to all scripts so it can be sourced to make zcomet available
export ZCOMET_SOURCE=$ZCOMET[SCRIPT]
export MY_ZCOMET

# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh); do
    source $config_file
done
unset config_file

autoload -Uz $MY_ZCOMET/functions/*
