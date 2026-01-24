#!/bin/bash
# Ensure ~/.bashrc sources MinGW-Lite Config and set up local env template

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
BASHRC="$HOME/.bashrc"
LOCAL_ENV="$HOME/.local-env.sh"
TEMPLATE="$REPO_ROOT/.local-env.sh.example"

SNIPPET=$(cat <<EOF
# MinGW-Lite Configuration
if [ -f "$HOME/.bash_compiled" ]; then
    source "$HOME/.bash_compiled"
elif [ -f "$REPO_ROOT/bash/core.sh" ]; then
    source "$REPO_ROOT/bash/core.sh"
fi
EOF
)

ensure_bashrc() {
    if [ ! -f "$BASHRC" ]; then
        echo "Creating $BASHRC"
        touch "$BASHRC"
    fi

    if grep -Fq "$REPO_ROOT/bash/core.sh" "$BASHRC" || grep -Fq "MinGW-Lite Configuration" "$BASHRC"; then
        echo "OK: $BASHRC already loads MinGW-Lite Config"
        return
    fi

    {
        echo ""
        echo "$SNIPPET"
    } >> "$BASHRC"

    echo "Added MinGW-Lite snippet to $BASHRC"
}

ensure_local_env() {
    if [ -f "$LOCAL_ENV" ]; then
        echo "OK: $LOCAL_ENV already exists"
        return
    fi

    if [ ! -f "$TEMPLATE" ]; then
        echo "Error: template missing at $TEMPLATE" >&2
        return 1
    fi

    cp "$TEMPLATE" "$LOCAL_ENV"
    echo "Created $LOCAL_ENV from template"
}

main() {
    echo "Setting up MinGW-Lite Config..."
    ensure_bashrc
    ensure_local_env
    echo "Done. Restart your shell to apply."
}

main "$@"