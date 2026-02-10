# .dotfiles

My personal configuration files for Linux/macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Overview

This repository contains configurations for:
- **Shell:** Zsh (with Oh My Zsh, custom plugins)
- **Editor:** Neovim (LazyVim based custom config)
- **Terminal:** Alacritty, Kitty, WezTerm
- **Multiplexer:** Tmux, Zellij
- **Tools:** Git, Bat, Eza, FZF, and more.

## Installation

### Prerequisites
- `git`
- `stow`
- `zsh`

### Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/.dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Bootstrap:
   ```bash
   # Make the setup script executable (coming soon)
   chmod +x setup.sh
   ./setup.sh
   ```

3. Manual Stow (if not using setup script):
   ```bash
   stow zsh
   stow nvim
   stow tmux
   # ... add other directories as needed
   ```

## Documentation
- [Linux Notes & Distrobox](docs/linux-notes.md)
- [Rust CLI Alternatives](docs/rust-tools.md)
