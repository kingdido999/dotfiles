#!/usr/bin/env bash
set -euo pipefail

echo "=== Dotfiles Bootstrap ==="

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages
echo "Installing packages from Brewfile..."
brew bundle install --file="$(dirname "$0")/Brewfile"

# Stow all packages
echo "Stowing dotfiles..."
cd "$(dirname "$0")"
stow helix fish git tmux

# Install Fisher and plugins
if ! fish -c "type -q fisher" 2>/dev/null; then
    echo "Installing Fisher..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

echo "Installing Fish plugins..."
fish -c "fisher update"

# Add Fish to allowed shells and set as default
FISH_PATH="$(which fish)"
if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "Adding Fish to /etc/shells (requires sudo)..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "Setting Fish as default shell..."
    chsh -s "$FISH_PATH"
fi

echo "=== Done! Restart your terminal. ==="
