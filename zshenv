echo "Hello from .zshenv"

# .zshenv is only loaded by interactive zshrc shells

mkcd () {
    mkdir -p "$@" && cd "$_"
}

exists() {
    # `command -v` is similar to `which`
    command -v $1 >/dev/null 2>&1
    # equivalent to: `command -v 1>/dev/null 2>/dev/null` (discard stdout and stderr)
}

