echo "Hello from .zshenv"

# .zshenv is only loaded by interactive zshrc shells

mkcd () {
    mkdir -p "$@" && cd "$_"
}

exists() {
    command -v $1 >/dev/null 2>&1
}


