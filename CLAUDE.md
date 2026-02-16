# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Dotfiles managed with GNU Stow. Each top-level directory is a stow package whose internal structure mirrors the target location relative to `~`. Packages are installed via Homebrew (declared in `Brewfile`). Fish plugins are managed by Fisher (declared in `fish/.config/fish/fish_plugins`).

## Commands

```bash
# Deploy/update symlinks (run from ~/dotfiles)
stow <package>          # Symlink a single package (e.g., stow helix)
stow helix fish git tmux claude  # Stow all packages
stow -D <package>       # Remove symlinks for a package
stow -R <package>       # Restow (remove then re-create)

# Package management
brew bundle install     # Install all packages from Brewfile
brew bundle dump --force  # Regenerate Brewfile from installed packages

# Fish plugins
fish -c "fisher update"  # Install/update plugins from fish_plugins

# Full bootstrap on a new machine
./install.sh
```

## Architecture

### Stow Packages

| Package | Target | What it configures |
|---------|--------|--------------------|
| `helix/` | `~/.config/helix/` | Editor config + Alabaster theme |
| `fish/` | `~/.config/fish/` | Shell config, aliases, PATH, plugin list |
| `git/` | `~/.gitconfig` | User identity, conditional work config via `includeIf` |
| `tmux/` | `~/.tmux.conf` | Prefix key, vi mode, TPM plugins |
| `claude/` | `~/.claude/` | Claude Code settings (base + OS-specific hooks merged at install) |

### Adding a New Stow Package

1. Create `<name>/.path/to/config` mirroring the home directory structure
2. Run `stow <name>` from repo root
3. Add `<name>` to the `stow` line in `install.sh`

### OS-Specific Config

Fish config uses `if test (uname) = "Darwin"` for macOS-specific PATH entries. Use the same pattern for other OS-conditional settings.

### tmux Note

`default-shell` in `.tmux.conf` is hardcoded to `/usr/local/bin/fish`. This path varies per machine (e.g., `/opt/homebrew/bin/fish` on Apple Silicon Macs). Adjust after stowing if needed.
