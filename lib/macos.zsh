# Return if not on macOS
[[ "$OSTYPE" != darwin* ]] && return

alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

# To find GPG keys in Keychain search for gnupg
alias gpg-keychain-option-enable="defaults write org.gpgtools.common DisableKeychain -bool no"
alias gpg-keychain-option-disable="defaults write org.gpgtools.common DisableKeychain -bool yes"