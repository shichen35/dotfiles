# Windsurf: If running in Cascade Terminal, use bash
if [[ "$WINDSURF_CASCADE_TERMINAL" == "1" ]]; then
  exec bash
fi

# =============================================================================
# 1. ENVIRONMENT & PATHS
# =============================================================================
# Note: Let the terminal set TERM. Only uncomment if you have specific issues.
export TERM="xterm-256color"

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
    if [[ -d "/opt/homebrew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    export PATH=$PATH:$HOME/go/bin
    ;;
  linux*)
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    if [[ -d "/home/linuxbrew" ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    ;;
esac

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
# Don't save these commands to history
HISTORY_IGNORE="(ls|cd|pwd|exit|clear|reset|bg|fg|history|cd ..*)"

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

# Hook to prevent certain commands from entering history (uses HISTORY_IGNORE)
zshaddhistory() {
  emulate -L zsh
  ## Uncomment if you want to use the HISTORY_IGNORE regex above:
  # [[ $1 =~ $HISTORY_IGNORE ]] && return 1
  # whence ${${(z)1}[1]} >| /dev/null || return 1 # Your original check (command validity)
  return 0
}

# =============================================================================
# 4. TOOL INITIALIZATION & FZF
# =============================================================================

# Fun startup
if (( $+commands[fortune] )); then
    fortune $DOTFILES/art/tang300 $DOTFILES/art/song100
fi

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
# 5. ALIASES
# =============================================================================
alias reset='tput reset'
alias cmds='history | awk '\''{print $2}'\'' | sort | uniq -c | sort -nr | head -n 6'
alias eh="$EDITOR \"+normal G\" ~/.zsh_history"
alias lg='lazygit'
alias la='ls -lah'
alias lastmod='fd --no-ignore -t f -0 | xargs -0 ls -lrt --color=auto | tail -n 10'

# Use wezterm fallback if not defined
((!$+commands[wezterm])) && alias wezterm='flatpak run org.wezfurlong.wezterm'

# Git Aliases
alias ga="git add"
alias gb="git branch"
alias gch="git checkout"
alias gc="git commit"
alias gca="git commit --amend"
alias gd="git diff"
alias gds="git diff --staged"
alias glg="git log --all --oneline --graph --decorate"
alias gpl="git pull --prune"
alias gps="git push --no-verify"
alias gm="git merge"
alias gs="git status"
alias gss="git status -sb"
alias gsw="git switch"
alias grs="git restore --staged"

# =============================================================================
# 6. FUNCTIONS
# =============================================================================

# Load completion only on the first kubectl
# function kubectl() {
#     unfunction "$0"
#     source <(command kubectl completion zsh)
#     $0 "$@"
# }

# Ripgrep + FZF
function rgfzf {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" \
  | fzf -d':' --ansi \
    --preview "command bat -p --color=always {1} --highlight-line {2}" \
    --preview-window ~8,+{2}-5 \
    --bind "enter:execute($EDITOR +{2} {1})" \
    --delimiter ":" \
    --nth 1,3..
}

# Yazi Wrapper (File Manager)
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Git Log with FZF
function fglog() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') << {}"
}

# Update custom OMZ plugins
function omzu() {
    printf "\x1b[38;5;117m%s\033[0m\n" "Updating custom omz plugins"
    for plugin in ~/.oh-my-zsh/custom/plugins/*/; do
        if [ -d "$plugin/.git" ]; then
            printf "\033[0;33m%s\033[0m\n" "${plugin%/}"
            git -C "$plugin" pull
        fi
    done
    # Re-source to apply changes
    source "$ZSH/oh-my-zsh.sh"
    omz update
}

function vdiff () {
    if [ "${#}" -ne 2 ] ; then
        echo "Usage: vdiff <file_or_dir_a> <file_or_dir_b>"
        return 1
    fi
    if [ -d "${1}" ] && [ -d "${2}" ]; then
        vim +"DirDiff ${1} ${2}"
    else
        vim -d "${1}" "${2}"
    fi
}

function colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m${i} ";
    done
    printf "\n";
}

# Execution Timer Functions
function displaytime {
    local T=$1
    local NC='\033[0m'
    if (( T > 1000 )); then
        (( T = T/1000.0 ))
        local Y=$((T/365/60/60/24))
        local D=$((T/60/60/24%365))
        local H=$((T/60/60%24))
        local M=$((T/60%60))
        local S=$((T%60))
        [[ $Y -ge 1 ]] && printf '%dy ' $Y
        [[ $D -ge 1 ]] && printf '%dd ' $D
        [[ $H -ge 1 ]] && printf '%dh ' $H
        [[ $M -ge 1 ]] && printf '%dm ' $M
        printf "%.3fs${NC}\n" $S
    else
        printf "%dms${NC}\n" $T
    fi
}

function preexec() {
    if [[ $time == "on" ]]; then
        timer=$(($(print -P %D{%s%6.})/1000))
    fi
}

function precmd() {
    local GRAY='\033[0;90m'
    if [[ $timer && $time == "on" ]]; then
        local now=$(($(print -P %D{%s%6.})/1000))
        local elapsed=$(($now-$timer))
        printf "${GRAY}elapsed "
        displaytime $elapsed
        unset timer
    fi
}

# =============================================================================
# 7. TRANSIENT PROMPT & WIDGETS (Advanced)
# =============================================================================

function reset-prompt-and-accept-line() {
    reset-prompt
    zle accept-line
    RPROMPT='%(?..%B(%?%)%b)'
}

function reset-prompt() {
    if [[ -n ${BUFFER//[[:space:]]/} ]]; then
        OLD_PROMPT="$PROMPT"
        PROMPT='%{%F{245}%}[%D{%H:%M:%S}]>%f '
        zle reset-prompt
        PROMPT="$OLD_PROMPT"
    fi
}

function reset-prompt-and-accept-and-hold() {
    reset-prompt
    zle accept-and-hold
}

function reset-prompt-and-accept-and-down-history() {
    reset-prompt
    zle accept-line-and-down-history
}

# Register Widgets
zle -N reset-prompt-and-accept-line
zle -N reset-prompt-and-accept-and-hold
zle -N reset-prompt-and-accept-and-down-history

# Add to autosuggest clear widgets
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
    reset-prompt-and-accept-line
    reset-prompt-and-accept-and-hold
    reset-prompt-and-accept-and-down-history
)

# Help tldr+fzf
function tf() {
  tldr --list | fzf --preview "tldr {} --color=always" --preview-window=right:70% | xargs tldr
}

# Help tldr with bat preview
function run_tldr_bat_view() {
    local cmd="${BUFFER%% *}"
    [[ -z "$cmd" ]] && return

    local real_cmd="${aliases[$cmd]:-$cmd}"
    real_cmd="${real_cmd%% *}"

    if ! tldr "$real_cmd" >/dev/null 2>&1; then
        zle -M "tldr: No entry found for '$real_cmd'"
        return
    fi

    zle -I

    tldr "$real_cmd" --color always --pager

    zle redisplay
}
zle -N run_tldr_bat_view
bindkey '^[t' run_tldr_bat_view
bindkey -M viins '^[t' run_tldr_bat_view

# Custom Help Widget
function print_my_help() {
    zle -M "" && zle -R
    [[ -z "$BUFFER" ]] && return
    if ! command -v glow &> /dev/null; then
        zle -M "Error: 'glow' not found."
        return
    fi
    local help_file=~/.dotfiles/knowledge/40\ Library/Reference/Linux\ Commands/"$BUFFER".md
    if [[ ! -f "$help_file" ]]; then
        zle -M "Error: Help file for '$BUFFER' not found."
        return
    fi
    command glow "$help_file"
    zle reset-prompt
}
zle -N print_my_help
bindkey '^[h' print_my_help
bindkey -M viins '^[h' print_my_help

# Edit Help Widget
function edit_my_help() {
    zle -M "" && zle -R
    [[ -z "$BUFFER" ]] && return
    command $EDITOR ~/.dotfiles/knowledge/40\ Library/Reference/Linux\ Commands/"$BUFFER".md
    
    zle reset-prompt
}
zle -N edit_my_help
bindkey '^[o' edit_my_help
bindkey -M viins '^[o' edit_my_help

# Open Knowledge Widget
function open_knowledge() {
    zle -M "" && zle -R
    $EDITOR '+cd $DOTFILES/knowledge/' '+FzfLua live_grep'
}
zle -N open_knowledge
bindkey '^[k' open_knowledge
bindkey -M viins '^[k' open_knowledge


# VI Mode Hooks
function zvm_after_init() {
  # Bind keys for transient prompt integration
  bindkey -M viins '^M' reset-prompt-and-accept-line
  bindkey -M vicmd '^M' reset-prompt-and-accept-line
  bindkey -M viins '^[a' reset-prompt-and-accept-and-hold
  bindkey -M vicmd '^[a' reset-prompt-and-accept-and-hold
  bindkey -M viins '^o' reset-prompt-and-accept-and-down-history
  bindkey -M vicmd '^o' reset-prompt-and-accept-and-down-history

  # Fix Ctrl+R for atuin integration
  bindkey '^r' atuin-search
}

# Initial Key bindings (Pre-zvm load)
bindkey '^M' reset-prompt-and-accept-line
bindkey '^[a' reset-prompt-and-accept-and-hold
bindkey '^o' reset-prompt-and-accept-and-down-history

# Work Config
source "$HOME/.dotfiles/zsh-files/work.zsh"
