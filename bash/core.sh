#!/bin/bash
# MinGW-Lite Config - Plugin Orchestrator
# This file only sources plugins in order - nothing else!

# Determine config directory
BASH_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source optional user-specific local environment configuration first
# This must be loaded before plugins since they may depend on these variables
if [ -f "$HOME/.local-env.sh" ]; then
    source "$HOME/.local-env.sh"
fi

# Define plugin load order
PLUGINS=(
    "env"
    "custom-paths"
    "ms-terminal-prompt"
    "key-bindings"
    "aliases"
    "functions"
    "lazy"
    "z"
    "fzf-key-bindings"
    "fzf-completion"
    "git"
)

# Source each plugin
for plugin in "${PLUGINS[@]}"; do
    plugin_path="$BASH_CONFIG_DIR/plugins/${plugin}.sh"
    if [ -f "$plugin_path" ]; then
        source "$plugin_path"
    else
        echo "Warning: Plugin not found: ${plugin}.sh" >&2
    fi
done
