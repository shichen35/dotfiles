# Windsurf: If running in Cascade Terminal, use bash
if [[ "$WINDSURF_CASCADE_TERMINAL" == "1" ]]; then
  exec bash
fi

# =============================================================================
# 1. ENVIRONMENT & PATHS
# =============================================================================
# Note: Let the terminal set TERM. Only uncomment if you have specific issues.
[[ -z "${TERM-}" ]] && export TERM="xterm-256color"

# Ensure PATH arrays contain unique entries
typeset -U PATH path

export VISUAL="nvim"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

export DOTFILES=$HOME/.dotfiles
export ZSH="$HOME/.oh-my-zsh"

# OS Specific Configuration (Homebrew & Go)
case ${OSTYPE} in
  darwin*)
    [ -f "$DOTFILES/zsh-files/mac.zsh" ] && source "$DOTFILES/zsh-files/mac.zsh"
    # Check for Apple Silicon Homebrew
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    ;;
  linux*)
    path+=("/usr/local/go/bin")
    setopt re_match_pcre
    if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      export ELECTRON_OZONE_PLATFORM_HINT=wayland
    fi
    ;;
esac
path+=("$HOME/go/bin" "$HOME/.local/bin" "$HOME/.cargo/bin")

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

# Autosuggest Settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# ZSH_AUTOSUGGEST_USE_ASYNC="true"

# Add a delay for autocomplete
# zstyle ':autocomplete:*' delay 1

# Plugins
# Note: zsh-syntax-highlighting must be LAST.
plugins=(
  # zsh-autocomplete
  # zsh-completions
  zsh-vi-mode
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load OMZ
[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# 3. HISTORY CONFIGURATION
# =============================================================================
HISTFILE=~/.zsh_history
SAVEHIST=1000
HISTSIZE=1000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# =============================================================================
# 4. TOOL INITIALIZATION & FZF
# =============================================================================

# Fun startup
# if (( $+commands[fortune] )); then
#     fortune "$DOTFILES/art/tang300" "$DOTFILES/art/song100"
# fi

# Bat / Exa / Manpager config
if (( $+commands[bat] )); then
  alias bcat='bat --style=plain --theme=gruvbox-dark --paging=never --color=always'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi
if (( $+commands[eza] )); then
  alias el='eza -l --icons --git -a'
  alias et='eza --tree --level=2 --icons'
fi

# FZF Configuration
FZF_COLORS="bg+:-1,fg:gray,fg+:white,border:black,spinner:0,hl:yellow,header:blue,info:green,pointer:red,marker:red,prompt:gray,hl+:red"

export FZF_DEFAULT_OPTS="--color=$FZF_COLORS --prompt '∷ ' --pointer ▶ --marker ⇒"

# Helper variable for preview commands to reduce duplication
_fzf_preview_cmd="if [[ \$(file --mime {}) =~ text ]]; then bat --style=plain --paging=never --color=always {}; elif [[ -d {} ]]; then echo Directory contents:; find {} -mindepth 1 -maxdepth 1 -not -name \".*\" -type d | xargs -I+ bash -c 'echo \"$(basename +)/\"' | sort && find {} -mindepth 1 -maxdepth 1 -not -name \".*\" -type f | xargs -I+ bash -c 'echo \"$(basename +)\"' | sort; else echo Not a text file; fi"

export FZF_CTRL_T_OPTS="--preview \"$_fzf_preview_cmd\""
export FZF_ALT_C_OPTS="--preview \"find {} -mindepth 1 -maxdepth 1 -not -name \\\".*\\\" -type d | xargs -I+ bash -c 'echo \\\"$(basename +)/\\\"' | sort && find {} -mindepth 1 -maxdepth 1 -not -name \\\".*\\\" -type f | xargs -I+ bash -c 'echo \\\"$(basename +)\\\"' | sort\""

if (( $+commands[fzf] )); then
    [ -f "$DOTFILES/zsh-files/key-bindings-fzf.zsh" ] && source "$DOTFILES/zsh-files/key-bindings-fzf.zsh"
fi

# Zoxide (Smart cd)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# Atuin (Shell History)
(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)"

# Distrobox
if [[ -n ${DISTROBOX_ENTER_PATH-} ]]; then
    (( $+commands[xdg-open])) && alias open="distrobox-host-exec xdg-open"
else
    (( $+commands[xdg-open])) && alias open="xdg-open"
fi

# =============================================================================
# 5. ALIASES & FUNCTIONS
# =============================================================================
[ -f "$DOTFILES/zsh-files/aliases.zsh" ] && source "$DOTFILES/zsh-files/aliases.zsh"
[ -f "$DOTFILES/zsh-files/functions.zsh" ] && source "$DOTFILES/zsh-files/functions.zsh"

# Work Config
[ -f "$DOTFILES/zsh-files/work.zsh" ] && source "$DOTFILES/zsh-files/work.zsh"

