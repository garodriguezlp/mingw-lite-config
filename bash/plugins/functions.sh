# functions.sh - Utility Functions

# Make directory and cd into it
mkcd() {
    if [ -z "$1" ]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# Quick directory navigation back up
up() {
    local d=""
    local limit=${1:-1}
    for ((i=1; i<=limit; i++)); do
        d="../$d"
    done
    cd "$d"
}
