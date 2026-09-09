# =============================================================================
# 1. ENVIRONMENT & PATHS
# =============================================================================
# Note: let the terminal set TERM. This only fills in a blank.
[[ -z "${TERM-}" ]] && export TERM="xterm-256color"

# Keep PATH free of duplicates.
typeset -U PATH path

export VISUAL="nvim"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

export DOTFILES=$HOME/.dotfiles
export ZSH="$HOME/.oh-my-zsh"

# PATH helpers. Defined here so mac.zsh, work.zsh and ~/.zshrc.local can use them.
path_prepend() {
  local p
  for p in "$@"; do
    [[ -n "$p" ]] && path=("$p" $path)
  done
}

path_append() {
  local p
  for p in "$@"; do
    [[ -n "$p" ]] && path+=("$p")
  done
}

# OS specific configuration (Homebrew & Go)
case ${OSTYPE} in
  darwin*)
    [ -f "$DOTFILES/zsh-files/mac.zsh" ] && source "$DOTFILES/zsh-files/mac.zsh"
    # Apple Silicon Homebrew
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    ;;
  linux*)
    path_append "/usr/local/go/bin"
    setopt re_match_pcre
    if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      export ELECTRON_OZONE_PLATFORM_HINT=wayland
    fi
    ;;
esac

path_append "$HOME/go/bin" "$HOME/.local/bin" "$HOME/.cargo/bin"

# =============================================================================
# 2. OH-MY-ZSH SETTINGS
# =============================================================================
# Theme
[ ! -v ZSH_THEME ] && ZSH_THEME="gentoo"

# Behavior
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"

# Autosuggest
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# Plugins
# Note: zsh-syntax-highlighting must be LAST.
plugins=(
  zsh-vi-mode
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# 3. HISTORY CONFIGURATION
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between sessions. Implies INC_APPEND_HISTORY.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
unsetopt HIST_BEEP               # No beep when history runs out. On by default in zsh.

# =============================================================================
# 4. TOOL INITIALIZATION & FZF
# =============================================================================

# Bat / Eza / Manpager
if (( $+commands[bat] )); then
  alias bcat='bat --style=plain --theme=gruvbox-dark --paging=never --color=always'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi
if (( $+commands[eza] )); then
  alias el='eza -l --icons --git -a'
  alias et='eza --tree --level=2 --icons'
fi

# FZF
FZF_COLORS="bg+:-1,fg:gray,fg+:white,border:black,spinner:0,hl:yellow,header:blue,info:green,pointer:red,marker:red,prompt:gray,hl+:red"
export FZF_DEFAULT_OPTS="--color=$FZF_COLORS --prompt '∷ ' --pointer ▶ --marker ⇒"

# Preview commands. Single-quoted on purpose: every {} and $ below must survive
# until fzf runs the preview, not be expanded while this file is sourced.
_fzf_dir_preview='{ ls -p {} | grep "/$" | sort; ls -p {} | grep -v "/$" | sort; } 2>/dev/null'
_fzf_file_preview='if command -v bat >/dev/null 2>&1; then bat --style=plain --paging=never --color=always {}; else cat {}; fi'
_fzf_preview='if [ -d {} ]; then '"$_fzf_dir_preview"'; elif file --mime {} 2>/dev/null | grep -q text; then '"$_fzf_file_preview"'; else echo "Not a text file"; fi'

export FZF_CTRL_T_OPTS="--preview '$_fzf_preview'"
export FZF_ALT_C_OPTS="--preview '$_fzf_dir_preview'"
unset _fzf_dir_preview _fzf_file_preview _fzf_preview

if (( $+commands[fzf] )); then
    [ -f "$DOTFILES/zsh-files/key-bindings-fzf.zsh" ] && source "$DOTFILES/zsh-files/key-bindings-fzf.zsh"
fi

# Zoxide (smart cd)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# Atuin (shell history)
(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)"

# Distrobox
if [[ -n ${DISTROBOX_ENTER_PATH-} ]]; then
    (( $+commands[xdg-open] )) && alias open="distrobox-host-exec xdg-open"
else
    (( $+commands[xdg-open] )) && alias open="xdg-open"
fi

# =============================================================================
# 5. ALIASES & FUNCTIONS
# =============================================================================
[ -f "$DOTFILES/zsh-files/aliases.zsh" ] && source "$DOTFILES/zsh-files/aliases.zsh"
[ -f "$DOTFILES/zsh-files/functions.zsh" ] && source "$DOTFILES/zsh-files/functions.zsh"

# =============================================================================
# 6. TOOLCHAINS & MACHINE-LOCAL OVERRIDES
# =============================================================================
# Version managers (nvm, sdkman, bun, pnpm, conda) live in work.zsh.
[ -f "$DOTFILES/zsh-files/work.zsh" ] && source "$DOTFILES/zsh-files/work.zsh"

# Anything specific to this one machine. Not tracked by git.
# See zsh-files/zshrc.local.example for the template.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
