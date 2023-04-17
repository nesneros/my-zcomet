[[ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] || return

tailscale() {
    /Applications/Tailscale.app/Contents/MacOS/Tailscale "$@"
}

