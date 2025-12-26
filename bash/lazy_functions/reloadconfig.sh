# lazy_functions/reloadconfig.sh - Configuration Recompiler & Reloader

reloadconfig() {
    echo "Recompiling MinGW-Lite configuration..."
    echo ""

    # Determine the path to mingw-compile relative to BASH_CONFIG_DIR
    local compile_script="$BASH_CONFIG_DIR/bin/mingw-compile"

    # Check if compile script exists
    if [ ! -f "$compile_script" ]; then
        echo "Error: Compile script not found at $compile_script"
        return 1
    fi

    # Run the compile script
    if bash "$compile_script"; then
        echo ""
        echo "Reloading configuration..."

        # Source the newly compiled configuration
        local compiled_file="$HOME/.bash_compiled"
        if [ -f "$compiled_file" ]; then
            source "$compiled_file"
            echo "✓ Configuration reloaded successfully!"
        else
            echo "Error: Compiled file not found at $compiled_file"
            return 1
        fi
    else
        echo "Error: Compilation failed"
        return 1
    fi
}
