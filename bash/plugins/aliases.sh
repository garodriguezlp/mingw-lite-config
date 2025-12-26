####################################################################################################
# ALIASES
####################################################################################################

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Profile and reload
alias profile='code ~/.bashrc'
alias src='source ~/.bashrc'

# Preferred implementations
alias less='less -FSRXc'                    # Enhanced 'less' command

# Terminal utilities
alias c='clear'                             # Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # Display all executable paths

# Custom tools
alias ctools="rm -rf $CUSTOM_BIN/*"         # Clear custom tools directory

# IntelliJ IDEA
alias idea='start idea64'

# Enhanced 'ls' aliases if 'eza' is available
if command -v eza &> /dev/null; then
    alias ls='eza'                                                         # Basic listing
    alias l='eza --git -lbF'                                               # List with size, type, git info
    alias ll='eza -lbGF --git'                                             # Long list
    alias llm='eza -lbGF --git --sort=modified'                            # Long list, sorted by modified date
    alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # Detailed list with all files
    alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # Detailed list with extended attributes
    alias lS='eza -1'                                                      # One column, just names
    alias lt='eza --tree --level=2'                                        # Tree view, 2 levels deep
fi