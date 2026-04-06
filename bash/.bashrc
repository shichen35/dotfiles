# =============================================================================
# 1. ENVIRONMENT
# =============================================================================
export VISUAL="nvim"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export DOTFILES="$HOME/.dotfiles"

# =============================================================================
# 2. PATH MANAGEMENT
# =============================================================================
path_prepend() {
  local p
  for p in "$@"; do
    if [[ -n "$p" && ":$PATH:" != *":$p:"* ]]; then
      export PATH="$p:$PATH"
    fi
  done
}

path_append() {
  local p
  for p in "$@"; do
    if [[ -n "$p" && ":$PATH:" != *":$p:"* ]]; then
      export PATH="$PATH:$p"
    fi
  done
}

# OS Specific paths
case ${OSTYPE} in
  darwin*)
    [ -f "$DOTFILES/bash-files/mac.bash" ] && source "$DOTFILES/bash-files/mac.bash"
    [[ -x "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    path_append "$HOME/go/bin"
    ;;
  linux-gnu*)
    path_append "/usr/local/go/bin" "$HOME/go/bin" "$HOME/.local/bin" "$HOME/.cargo/bin"
    [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
esac

path_prepend "$HOME/homebrew/bin"
path_append "/opt/nvim-linux-x86_64/bin" "$HOME/.local/platform-tools"

# =============================================================================
# 3. HISTORY
# =============================================================================
HISTFILE="$HOME/.bash_history"
HISTSIZE=1000
HISTFILESIZE=1000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s cmdhist

# =============================================================================
# 4. TOOL INITIALIZATION
# =============================================================================
# Bat / Eza
if command -v bat &>/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi

# FZF
export FZF_DEFAULT_OPTS="--color=bg+:-1,fg:gray,fg+:white,border:black,spinner:0,hl:yellow,header:blue,info:green,pointer:red,marker:red,prompt:gray,hl+:red --prompt '∷ ' --pointer ▶ --marker ⇒"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# =============================================================================
# 5. LANGUAGES & ENVIRONMENTS
# =============================================================================
# Bun
if [[ -x "$HOME/.bun/bin/bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  path_prepend "$BUN_INSTALL/bin"
fi

# Deno
[ -s "$HOME/.deno/env" ] && source "$HOME/.deno/env"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
path_prepend "$PNPM_HOME"

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
path_append "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools"

# SDKMan (must be last)
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
