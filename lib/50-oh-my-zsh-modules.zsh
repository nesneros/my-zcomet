# Include some standard functionality form OMZ
zcomet load ohmyzsh lib completion.zsh directories.zsh functions.zsh history.zsh key-bindings.zsh misc.zsh

# Load some OMZ plugins
zcomet load ohmyzsh plugins/dirhistory
zcomet load ohmyzsh plugins/macos

# Docker completion
zcomet fpath ohmyzsh plugins/docker
