#!/bin/bash
set -e

DOTFILES=$(dirname $(realpath "$0"))
cd "$DOTFILES"

echo "Starting Dotfiles Setup..."

# Function to check if a command exists
check_command() {
  if ! command -v "$1" &>/dev/null; then
    echo "Error: '$1' is not installed. Please install it before running this script."
    exit 1
  fi
}

check_command stow
check_command git
check_command zsh

# Function to backup existing files if they exist and are not symlinks
backup_if_exists() {
  local file=$1
  if [ -e "$file" ] && [ ! -L "$file" ]; then
    echo "Backing up existing $file to $file.bak"
    mv "$file" "$file.bak"
  fi
}

# 1. Install Zsh Plugins & OMZ
# We run this first because it installs dependencies and might create default config files
echo ">>> Setting up Zsh plugins..."
if [ -f "zsh-files/installs.zsh" ]; then
  zsh zsh-files/installs.zsh
else
  echo "Warning: zsh-files/installs.zsh not found."
fi

# 2. Prepare for Stow
# We need to move existing config files out of the way so Stow can link ours
echo ">>> preparing for stow..."
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.tmux.conf"
# Ensure target directories exist for some complex stow targets if needed,
# but usually Stow handles mkdir.
# However, if ~/.config/nvim is a real directory with files, Stow might conflict
# if we try to stow a folder over a folder.
# Our structure is nvim/.config/nvim/... so we are stowing `.config` into `~`.
# If `~/.config` exists (it does), Stow populates it.
# If `~/.config/nvim` exists and is a directory (not a symlink), we might need to back it up
# IF our stow package tries to replace the whole dir.
# Looking at file structure: nvim/.config/nvim/init.lua
# Stow will try to symlink individual files inside ~/.config/nvim if the dir exists.
# So we are likely fine unless conflicting files exist.

# 3. Run Stow
echo ">>> Stowing dotfiles..."
STOW_PACKAGES=(zsh tmux lvim vim kitty fastfetch) # alacritty wezterm clang-format

for pkg in "${STOW_PACKAGES[@]}"; do
  if [ -d "$pkg" ]; then
    echo "  - Stowing $pkg"
    stow -R "$pkg"
  fi
done

echo ">>> Setup Complete!"
