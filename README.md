<div align="center">
  <img src=".github/logo.png" alt="codelab logo">
</div>

# Codelab Configuration

My Neovim configuration built with Nixvim. This setup provides a fully declarative and reproducible development environment powered by Nix.

## Repository Structure

```text
.
├── config                  # Main configuration directory
│   ├── autocmd.nix         # Autocommand configurations
│   ├── default.nix         # Entry point for the config
│   ├── diagnostics.nix     # Diagnostics configuration
│   ├── files.nix           # File handling configuration
│   ├── filetypes.nix       # Filetype-specific settings
│   ├── keys.nix            # Keymapping configurations
│   ├── options.nix         # Neovim options configuration
│   ├── plugins             # Plugin configurations
│   └── sets.nix            # Custom setting collections
├── flake.lock              # Lockfile for Nix dependencies
├── flake.nix               # Nix flake configuration
└── packages                # Custom package definitions
```

