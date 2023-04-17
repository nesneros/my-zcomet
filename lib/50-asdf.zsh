if (( ! ${+commands[asdf]} )); then
  return
fi

# this should be default for ASDF_DEFAULT_TOOL_VERSIONS_FILENAME but explicit setting it removes from errors. Eg for asdf direnv envrc
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=.tool-versions
export ASDF_CONFIG_FILE=$MY_ZCOMET/dotfiles/asdfrc
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE=$MY_ZCOMET/dotfiles/default-golang-pkgs
