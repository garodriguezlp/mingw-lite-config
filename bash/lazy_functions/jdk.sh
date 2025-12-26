# lazy_functions/jdk.sh - JDK Version Switcher

jdk() {
    if [[ -z "${JDK_PATHS[*]}" ]]; then
        echo "Error: No JDK paths are defined. Please configure the JDK_PATHS array."
        return 1
    fi

    echo "Available Java versions:"
    for idx in "${!JDK_PATHS[@]}"; do
        echo "$((idx + 1))) ${JDK_PATHS[$idx]}"
    done

    read -p "Enter the number corresponding to the Java version you want to use: " choice
    if [[ "$choice" -lt 1 || "$choice" -gt "${#JDK_PATHS[@]}" ]]; then
        echo "Invalid selection. Please choose a valid option."
        return 1
    fi

    script_file="${BASH_SOURCE[0]}"
    selected_index=$((choice - 1))
    echo "Updating the script to persist the selected Java version for future sessions..."
    sed -i "s|export JAVA_HOME=\"\${JDK_PATHS\[[0-9]\]}\"|export JAVA_HOME=\"\${JDK_PATHS[$selected_index]}\"|" "$script_file"

    export java_home="${JDK_PATHS[$selected_index]}"
    export PATH="$java_home/bin:$PATH"

    echo "JAVA_HOME has been updated to: $java_home"
    echo "Verifying the Java installation..."
    java -version
}
