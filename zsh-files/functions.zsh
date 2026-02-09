# =============================================================================
# FUNCTIONS & WIDGETS
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
    printf "\x1b[38;5;117m%s\033[0m
" "Updating custom omz plugins"
    for plugin in ~/.oh-my-zsh/custom/plugins/*/; do
        if [ -d "$plugin/.git" ]; then
            printf "\033[0;33m%s\033[0m
" "${plugin%/}"
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
    printf "
";
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
        printf "%.3fs${NC}
" $S
    else
        printf "%dms${NC}
" $T
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
# TRANSIENT PROMPT & WIDGETS
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
    command glow -w 0 "$help_file"
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
