# Load lib folder
for config_file ($MY_ZCOMET/lib/*.zsh(N)); do
  source $config_file
done
unset config_file
