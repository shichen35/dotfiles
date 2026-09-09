#!/usr/bin/env bash
# One-time macOS system preferences.
# Run by installs.zsh during setup, or by hand: ./zsh-files/macos-defaults.sh
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "macos-defaults.sh: not macOS, nothing to do."
    exit 0
fi

# Key repeat: fast, and hold-to-repeat instead of the accent picker.
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Drag a window from anywhere with ctrl + cmd + click.
defaults write -g NSWindowShouldDragOnGesture -bool true

echo "macOS defaults applied. Log out and back in for all of them to take effect."
