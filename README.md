# MinGW-Lite Bash Configuration

A lightweight, modular Bash configuration system for MinGW/Git Bash on Windows. Designed for fast startup times and easy customization.

## What is MinGW-Lite Config?

MinGW-Lite Config provides a clean, organized way to manage your Bash environment on Windows. It focuses on:

- **Speed**: Lazy-loading functions keep startup times fast
- **Modularity**: Plugin-based architecture for easy customization
- **Simplicity**: Straightforward conventions for adding functionality
- **Performance**: Optional compilation for even faster shell startup

## Getting Started

### Quick Setup
Run the helper to wire `~/.bashrc` and copy the local env template:

```bash
bash bootstrap.sh
```

It ensures `~/.bashrc` sources [bash/core.sh](bash/core.sh) or a compiled file and creates `~/.local-env.sh` from [.local-env.sh.example](.local-env.sh.example) if missing.

### 1. Integrate with Your Shell

Add this to your `~/.bashrc`:

```bash
# MinGW-Lite Configuration
if [ -f "$HOME/.bash_compiled" ]; then
   source "$HOME/.bash_compiled"
elif [ -f "$HOME/src/mingw-lite-config/bash/core.sh" ]; then
   source "$HOME/src/mingw-lite-config/bash/core.sh"
fi
```

Reload your shell:
```bash
source ~/.bashrc
```

Test that it works:
```bash
ll              # List files with details
mkcd test       # Create and cd into directory
```

## How It Works

### Plugin System

Plugins are Bash scripts that load when your shell starts. They contain aliases, functions, and environment variables you want available immediately.

**Location**: [`bash/plugins/`](bash/plugins/)

#### Creating a New Plugin

1. **Create your plugin file**:
   ```bash
   # bash/plugins/docker.sh
   alias dps='docker ps'
   alias dim='docker images'

   dclean() {
       docker system prune -f
   }
   ```

2. **Register the plugin** in [`bash/core.sh`](bash/core.sh:1):
   ```bash
   PLUGINS=(
       "env"
       "aliases"
       "functions"
       "docker"      # <-- Add your plugin
       "lazy"        # Keep this last
   )
   ```

3. **Reload your shell**:
   ```bash
   source ~/.bashrc
   ```

**Important**: Don't use `exit` or shell-terminating commands in plugins - they'll break compilation and may close your shell.

### Lazy Loading Feature

Lazy-loaded functions aren't loaded at startup - they load automatically the first time you call them. This keeps shell startup fast while still providing access to heavier functions.

**Location**: [`bash/lazy_functions/`](bash/lazy_functions/)

#### Creating a Lazy Function

1. **Create a file named after your function**:
   ```bash
   # bash/lazy_functions/myproject.sh
   myproject() {
       cd ~/projects/myproject
       export PROJECT_ENV="production"
       echo "Loaded myproject environment"
   }
   ```

2. **Use it** - no registration needed:
   ```bash
   myproject  # First call loads the file
   myproject  # Subsequent calls are instant
   ```

The function name must match the filename (without `.sh`). The system automatically makes it available.

### Local Environment Configuration

For system-specific settings that shouldn't be in the repository (like paths, credentials, or machine-specific configs), use a local environment file.

**Create** `~/.local-env.sh` in your home directory (see [`.local-env.sh.example`](.local-env.sh.example:1) for a template):

```bash
# Custom PATH additions (opt-in feature using array)
CUSTOM_PATHS=(
    "/c/my-tools/bin"
    "/c/another-tool/bin"
    "~/local/bin"
)

# Private environment variables
export API_KEY="your-secret-key"
```

This file:
- Is **optional** - the system works without it
- Automatically loads if it exists
- Perfect for settings unique to your machine
- Won't be committed to version control

#### Custom PATH Additions

The [`custom-paths`](bash/plugins/custom-paths.sh:1) plugin provides an opt-in way to add multiple directories to your PATH using a Bash array.

**Usage**: Define the `CUSTOM_PATHS` array in your `~/.local-env.sh`:

```bash
CUSTOM_PATHS=(
    "/c/my-tools/bin"
    "/c/another-tool/bin"
    "~/local/bin"
    "$HOME/scripts"
)
```

**Features**:
- **Clean syntax**: Each path on its own line
- **Tilde expansion**: Use `~` for home directory
- **Variable expansion**: Use `$HOME` or other environment variables
- **Smart validation**: Only adds directories that exist
- **Duplicate prevention**: Won't add paths already in PATH

### Compilation Feature

For maximum startup speed, compile all plugins into a single file. This eliminates the overhead of sourcing multiple files.

**Compile and reload in one step**:
```bash
reloadconfig
```

This built-in lazy function (from [`bash/lazy_functions/reloadconfig.sh`](bash/lazy_functions/reloadconfig.sh:1)) automatically:
- Compiles all plugins into `~/.bash_compiled`
- Reloads the configuration in your current shell
- Shows compilation status and any errors

**Manual compilation** (if needed):
```bash
bash bash/bin/mingw-compile
```

**Development workflow**:
1. Edit plugins in [`bash/plugins/`](bash/plugins/)
2. Run `reloadconfig` to compile and reload
3. Test your changes immediately

## Project Structure

```
mingw-lite-config/
├── bash/
│   ├── core.sh              # Main entry point
│   ├── plugins/             # Eager-loaded plugins
│   │   ├── env.sh          # Environment variables
│   │   ├── aliases.sh      # Aliases
│   │   ├── functions.sh    # Utility functions
│   │   └── lazy.sh         # Lazy loader (keep last)
│   ├── lazy_functions/      # Lazy-loaded functions
│   │   └── jdk.sh          # Example: JDK switcher
│   └── bin/
│       └── mingw-compile    # Compilation script
└── README.md
```

## Quick Reference

**After making changes**: Run [`reloadconfig`](bash/lazy_functions/reloadconfig.sh:1) to recompile and reload your configuration.

**Manual reload** (dev mode): `source ~/.bashrc`

## License

MIT License - Use freely!
