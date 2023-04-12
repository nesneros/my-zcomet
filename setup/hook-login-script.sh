#! /usr/bin/env bash

set -e

# Only implemented for MacOS

setupDir=$(dirname -- "${BASH_SOURCE[0]}")/..
MY_ZCOMET=$(
    cd $setupDir
    pwd
)
name=zcomet.Custom.LoginScript

loginScript=$MY_ZCOMET/dotfiles/login.sh

if [[ $OSTYPE == darwin* ]]; then
    d=$(mktemp -d)
    tmp=/tmp/file.plist
    cat <<EOF >$tmp
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>EnvironmentVariables</key>
    <dict>
           <key>MY_ZCOMET</key>
           <string>$MY_ZCOMET</string>
    </dict>
    <key>Label</key>
    <string>$name</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/sh</string>
        <string>$loginScript</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

    # cat $tmp

    launchctl remove $name || :
    #launchctl load -w "$tmp"

    cat $tmp >$HOME/Library/LaunchAgents/$name.plist

    rm -f "$tmp"
    rmdir $d
fi
