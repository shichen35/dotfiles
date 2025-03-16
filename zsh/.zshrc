# set -x
# setopt PRINT_EXIT_VALUE
# zmodload zsh/zprof

export TERM="xterm-256color"
export VISUAL="nvim"
export EDITOR="nvim"
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

case ${OSTYPE} in
    darwin*)
        source $DOTFILES/zsh-files/mac.zsh
        eval $(/opt/homebrew/bin/brew shellenv)
        export PATH=$PATH:$HOME/go/bin
        ;;
    linux*)
        export PATH=$PATH:/usr/local/go/bin
        ;;
    *) ;;
esac

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
[ ! -v ZSH_THEME ] && ZSH_THEME="agnoster"

DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_USE_ASYNC="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode) # zsh-autocomplete git command-not-found adb podman rust fd ripgrep docker docker-compose zsh-completions zsh-autocomplete
DISABLE_AUTO_UPDATE=true
# fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
[ -s $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

# autoload -Uz compinit
# compinit

# User configuration
# (( $+commands[figlet] )) && (( $+commands[lolcat] )) && (( $+commands[fortune] )) && (figlet -f slant 'Rock & Code' && fortune)|lolcat;
(( $+commands[lolcat] )) && (( $+commands[fortune] )) && fortune tang300 song100;

HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
# HISTORY_IGNORE="(cd|cd ..*|ps|ls|la|l|ll|pwd|clear|reset|man *|history*|vim|vi|nvim)"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# alias vim=nvim
alias reset='tput reset'
alias cmds='history | awk '\''{print $2}'\'' | sort | uniq -c | sort -nr | head -n 6'
if (( $+commands[bat] )); then
    alias bcat='bat --style=plain --theme=gruvbox-dark --paging=never --color=always'
    alias bat='bat --theme=gruvbox-dark --color=always --wrap=never'
    export MANPAGER="sh -c 'col -bx | bat --theme=gruvbox-dark -l man -p'"
fi
# (( $+commands[exa] )) && alias ls='exa'
alias lg='lazygit'
#alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias lvim="NVIM_APPNAME=lazyvim nvim"
# (( $+commands[macchina] )) && alias neofetch="macchina"
alias la='ls -lah'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='fd --no-ignore -t f -0|xargs -0 ls -lrt --color=auto|tail -n 10'

function rgfzf {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" \
| fzf -d':' --ansi \
  --preview "command bat -p --color=always {1} --highlight-line {2}" \
  --preview-window ~8,+{2}-5 \
  --bind "enter:execute($EDITOR +{2} {1})" \
  --delimiter ":" \
  --nth 1
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function reset-prompt-and-accept-line() {
    reset-prompt
    zle accept-line
    RPROMPT='%(?..%B(%?%)%b)'
}

function reset-prompt() {
    if [ -n "${BUFFER##*( )}" ]; then
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

# TRAPERR() {
#   print -u2 Exit status: $?
# }

# bind hstr to Ctrl-r (for Vi mode check doc)
bindkey -s "^[r" " $EDITOR \"+normal G\" ~/.zsh_history^M";

# Register the widgets for transient prompt
zle -N reset-prompt-and-accept-line
zle -N reset-prompt-and-accept-and-hold
zle -N reset-prompt-and-accept-and-down-history

# Add to autosuggest clear widgets
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-line
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-and-hold
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-and-down-history

# Define a function to be called after zsh-vi-mode initializes
function zvm_after_init() {
  # Bind keys in both vi insert and normal modes for transient prompt
  bindkey -M viins '^M' reset-prompt-and-accept-line
  bindkey -M vicmd '^M' reset-prompt-and-accept-line
  bindkey -M viins '^[a' reset-prompt-and-accept-and-hold
  bindkey -M vicmd '^[a' reset-prompt-and-accept-and-hold
  bindkey -M viins '^o' reset-prompt-and-accept-and-down-history
  bindkey -M vicmd '^o' reset-prompt-and-accept-and-down-history

  # Fix Ctrl+R for atuin when zsh-vi-mode is enabled
  bindkey '^r' atuin-search
}

# Set up initial bindings (these will work before zsh-vi-mode loads)
bindkey '^M' reset-prompt-and-accept-line
bindkey '^[a' reset-prompt-and-accept-and-hold
bindkey '^o' reset-prompt-and-accept-and-down-history

# Define a function to print my help on the prompt text
function print_my_help() {
    zle -M ""
    zle -R
    [[ -z "$BUFFER" ]] && return

    # Check if the glow command exists
    if ! command -v glow &> /dev/null; then
        zle -M "Error: 'glow' command not found. Please install it to view the help documentation."
        return
    fi

    # Check if the help file exists, print error message if not
    if [[ ! -f ~/.dotfiles/knowledge/cmd/"$BUFFER".md ]]; then
        zle -M "Error: Help file for '$BUFFER' not found."
        return
    fi

    # Display the help file using glow
    command glow ~/.dotfiles/knowledge/cmd/"$BUFFER".md
    zle reset-prompt
}

# Bind the Esc + h key combination to my custom command
zle -N print_my_help
bindkey -r "^[h"
bindkey '^[h' print_my_help

# Define a function to edit my help on the prompt text
function edit_my_help() {
    zle -M ""
    zle -R
    [[ -z "$BUFFER" ]] && return
    command $EDITOR ~/.dotfiles/knowledge/cmd/"$BUFFER".md
    zle reset-prompt
}

# Bind the Esc + h key combination to my custom command
zle -N edit_my_help
bindkey -r "^[o"
bindkey '^[o' edit_my_help

function open_knowledge() {
    zle -M ""
    zle -R
    $EDITOR '+cd $DOTFILES/knowledge/' '+Telescope live_grep'
}

zle -N open_knowledge
bindkey -r "^[k"
bindkey '^[k' open_knowledge

# This function is executed before the command line is written to history. If it does return 1, the current command line is neither appended to the history file nor to the local history stack.
function zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

function displaytime {
    local T=$1
    if (( T > 1000 )) then
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
    if [[ $time == "on" ]] then
        timer=$(($(print -P %D{%s%6.})/1000))
    fi
}

function precmd() {
    # local exit_code=$?
    GRAY='\033[0;90m'
    CYAN='\033[1;37m'
    NC='\033[0m' # No Color

    if [[ $timer && $time == "on" ]]; then
        now=$(($(print -P %D{%s%6.})/1000))
        elapsed=$(($now-$timer))

        # export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
        printf "${GRAY}elapsed "
        displaytime $elapsed
        unset timer
    fi
}

function vdiff () {
    if [ "${#}" -ne 2 ] ; then
        echo "vdiff requires two arguments"
        echo "  comparing dirs:  vdiff dir_a dir_b"
        echo "  comparing files: vdiff file_a file_b"
        return 1
    fi

    local left="${1}"
    local right="${2}"

    if [ -d "${left}" ] && [ -d "${right}" ]; then
        vim +"DirDiff ${left} ${right}"
    else
        vim -d "${left}" "${right}"
    fi
}

# function colors() {
#     for i in {0..255};
#     do
#         printf "\x1b[38;5;${i}m${i} ";
#     done
#     printf "\n";
# }

# function timezsh() {
#     shell=${1-$SHELL}
#     for i in $(seq 1 5); do time $shell -i -c exit; done
# }

# # fglog - git log browser with FZF
function fglog() {
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') << {}"
}

function omzu() {
    printf "\x1b[38;5;117m%s\033[0m\n" "Updating custom omz plugins"
    for plugin in ~/.oh-my-zsh/custom/plugins/*/; do
        if [ -d "$plugin/.git" ]; then
            printf "${YELLOW}%s${RESET}\n" "${plugin%/}"
            git -C "$plugin" pull
            source $ZSH/oh-my-zsh.sh
        fi
    done
    omz update
}


FZF_COLORS="bg+:-1,\
fg:gray,\
fg+:white,\
border:black,\
spinner:0,\
hl:yellow,\
header:blue,\
info:green,\
pointer:red,\
marker:red,\
prompt:gray,\
hl+:red"

export FZF_DEFAULT_OPTS="--color='$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"

export FZF_CTRL_T_OPTS="--preview \"if [[ \$(file --mime {}) =~ text ]]; then bat --style=plain --paging=never --color=always {}; elif [[ -d {} ]]; then echo Directory contents:; find {} -mindepth 1 -maxdepth 1 -not -name \\\".*\\\" -type d | xargs -I+ bash -c 'echo \\\"$(basename +)/\\\"' | sort && find {} -mindepth 1 -maxdepth 1 -not -name \\\".*\\\" -type f | xargs -I+ bash -c 'echo \\\"$(basename +)\\\"' | sort; else echo Not a text file; fi\""
export FZF_ALT_C_OPTS="--preview \"find {} -mindepth 1 -maxdepth 1 -not -name \\\".*\\\" -type d | xargs -I+ bash -c 'echo \\\"$(basename +)/\\\"' | sort && find {} -mindepth 1 -maxdepth 1 -not -name \\\".*\\\" -type f | xargs -I+ bash -c 'echo \\\"$(basename +)\\\"' | sort\""

if (( $+commands[fzf] )); then
    source $DOTFILES/zsh-files/key-bindings-fzf.zsh
fi

# if (($+commands[fzf] && $+commands[rg])) then
#     export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
#     export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#     source $DOTFILES/zsh-files/key-bindings-fzf.zsh
# fi

# Skim keybindings
# (($+commands[sk] && $+commands[rg])) && source $DOTFILES/zsh-files/key-bindings-skim.zsh
# if (($+commands[rg] && $+commands[fd])) then
#   export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
#   export SKIM_CTRL_R_OPTS="--color=fg:243,fg+:255,current_match_bg:239,hl:3,hl+:2,matched_bg:-1"
#   export SKIM_CTRL_T_OPTS="--color=fg:243,fg+:255,current_match_bg:239,hl:3,hl+:2,matched_bg:-1"
# fi

# Zoxide
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

if (( $+commands[atuin] )) then
    eval "$(atuin init zsh)"
fi


if [ -f $HOME/.bun/bin/bun ]; then
    # bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

    # bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"

    # bun completions
    [ -s "/Users/chen.shi/.bun/_bun" ] && source "/Users/chen.shi/.bun/_bun"
fi

# export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# zprof|head

# pnpm
export PNPM_HOME="/home/deck/distro-arch/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

