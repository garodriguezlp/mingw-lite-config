#!/bin/bash
# Custom PATH Additions Plugin
# Add custom directories to PATH from array variable

# Add the repo's bin directory to PATH if BASH_CONFIG_DIR is set
if [ -n "$BASH_CONFIG_DIR" ]; then
    bin_dir="$BASH_CONFIG_DIR/bin"
    if [ -d "$bin_dir" ] && [[ ":$PATH:" != *":$bin_dir:"* ]]; then
        export PATH="$bin_dir:$PATH"
    fi
fi

# Check if CUSTOM_PATHS array is set and not empty
if [ -n "${CUSTOM_PATHS+x}" ] && [ ${#CUSTOM_PATHS[@]} -gt 0 ]; then
    for custom_path in "${CUSTOM_PATHS[@]}"; do
        # Safely expand ~ to HOME directory (without dangerous eval)
        expanded_path="${custom_path/#\~/$HOME}"

        # Expand environment variables safely using bash parameter expansion
        # This handles $VAR and ${VAR} syntax
        expanded_path=$(printf '%s\n' "$expanded_path" | envsubst 2>/dev/null || echo "$expanded_path")

        # Only add if directory exists and isn't already in PATH
        # Double quotes ensure paths with spaces are handled correctly
        if [ -d "$expanded_path" ] && [[ ":$PATH:" != *":$expanded_path:"* ]]; then
            export PATH="$expanded_path:$PATH"
        fi
    done
fi
