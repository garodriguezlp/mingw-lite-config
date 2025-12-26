# Default editor
export EDITOR=vim

# Bash history size
HISTSIZE=2000
HISTFILESIZE=2000

# Function to dynamically determine the script's full path and open it for editing
edit-env() {
    local script_path
    script_path=$(realpath "${BASH_SOURCE[0]}")  # Full path to this script
    code "$script_path"
}