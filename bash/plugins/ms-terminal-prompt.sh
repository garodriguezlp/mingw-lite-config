# Microsoft Terminal: Split Pane/Tab - Same Directory
export PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND"}'printf "\e]9;9;%s\e\\" "`cygpath -w "$PWD" -C ANSI`"'

# Sync bash history across sessions
export PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND"}';history -a; history -n;'