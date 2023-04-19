# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh); do
    source $config_file
done
unset config_file

autoload -Uz $MY_ZCOMET/functions/*
