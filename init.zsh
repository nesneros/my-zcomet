# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh(N)); do
    source $config_file
done
unset config_file

autoload -Uz $MY_ZCOMET/functions/*

# Remove non-existing dirs from path
setopt EXTENDED_GLOB
path=(${^path}(N))
