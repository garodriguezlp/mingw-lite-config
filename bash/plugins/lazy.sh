# lazy.sh - Lazy Function Loader

# This plugin initializes lazy loading for functions in lazy_functions/
# It must be loaded last since it depends on BASH_CONFIG_DIR

# Check if BASH_CONFIG_DIR is set
if [ -z "$BASH_CONFIG_DIR" ]; then
    echo "Warning: BASH_CONFIG_DIR not set, skipping lazy function loading" >&2
elif [ -d "$BASH_CONFIG_DIR/lazy_functions" ]; then
    for func_file in "$BASH_CONFIG_DIR/lazy_functions"/*.sh; do
        [ -f "$func_file" ] || continue

        # Extract function name from filename (without .sh)
        func_name=$(basename "$func_file" .sh)

        # Create lazy stub that loads on first call
        eval "$func_name() {
            unset -f $func_name
            source \"$func_file\"
            $func_name \"\$@\"
        }"
    done
fi
