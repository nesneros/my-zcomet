# https://github.com/maruel/panicparse
# Default panicparse is installed as 'pp'. For installation use: go install github.com/maruel/panicparse/v2@latest

# panicparse is install is asdf managed go so it wont work to guard setup with a check if panicparse is defined
#if (( ${+commands[panicparse]} )) ; then
    alias -g PP=" |& panicparse"
    
    function gorunpp {
        go run "$@" |& panicparse
    }

    alias gm="gorunpp main.go"
#fi

# https://golang.org/pkg/runtime/#hdr-Environment_Variables
# GOTRACEBACK=1
# The default. Prints a stack trace of all current goroutines.
# GOTRACEBACK=2
# Prints a stack trace of all current goroutines and the goroutines that created them.
# GOTRACEBACK=crash
# Prints the stack trace and then crashes with a non-zero exit code.
# GOTRACEBACK=system
# Prints the stack trace and then crashes with a non-zero exit code. The difference between this and GOTRACEBACK=crash is that the latter will not call the crash handler, which may be useful for debugging the crash handler itself.
export GOTRACEBACK=1

# See https://pkg.go.dev/runtime for values for GODEBUG
export GODEBUG=""
