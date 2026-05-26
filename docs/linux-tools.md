# Linux Command-Line utilities

## Rewritten in Rust: Modern Alternatives of Command-Line Tools

- sharkdp/bat             - A cat(1) clone with wings.
- sharkdp/fd              - A simple, fast and user-friendly alternative to find.
- sharkdp/hexyl           - A command-line hex viewer.
- BurntSushi/ripgrep      - A line-oriented search tool that recursively searches the current directory for a regex pattern.
- dbrgn/tealdeer          - A very fast implementation of tldr in Rust.
- lotabout/skim           - Fuzzy Finder in Rust!
- ogham/exa               - A modern replacement for ‘ls’.
- dalance/procs           - A modern replacement for ps written in Rust.
- bootandy/dust           - A more intuitive version of du in Rust.
- Byron/dua-cli           - View disk space usage and delete unwanted data, fast.
- XAMPPRocky/tokei        - Count your code, quickly.
- ClementTsang/bottom     - Yet another cross-platform graphical process/system monitor.
- imsnif/bandwhich        - Terminal bandwidth utilization tool.
- ellie/atuin             - Magical shell history.
- sxyazi/yazi             - Blazing fast terminal file manager written in Rust, based on async I/O.
- extrawurst/gitui        - Blazing fast terminal-ui for git written in Rust.
- o2sh/onefetch           - Command-line Git information tool.
- zellij-org/zellij       - A terminal workspace with batteries included.

## golang

- junegunn/fzf             - A command-line fuzzy finder.
- jesseduffield/lazygit    - Simple terminal UI for git commands.
- jesseduffield/lazydocker - The lazier way to manage everything docker.

## c/c++

- fastfetch-cli/fastfetch - A maintained, feature-rich and performance oriented, neofetch like system information tool.

## Install

cargo

```bash
cargo install cargo-update \
    atuin \
    tealdeer \
    fd-find \
    ripgrep \
    eza \
    dua-cli \
    yazi-fm \
    yazi-cli \
    zellij \
    onefetch \
    zoxide \
    tokei
```

homebrew

```bash
brew install tealdeer fd ripgrep yazi zoxide tokei dua-cli atuin fastfetch htop neovim fzf
```

arch

```bash
sudo pacman -Syy base base-devel fzf git go htop neovim openssh python python-pip stow tmux unzip wget zip zsh xclip

```
