# set -x
# setopt PRINT_EXIT_VALUE

# zmodload zsh/zprof
case ${OSTYPE} in
  darwin*)
    source $DOTFILES/zsh-files/mac.zsh
    ;;
  linux*)
    ;;
esac
[ -s $HOME/.cargo/env ] && source "$HOME/.cargo/env"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
[ ! -v ZSH_THEME ] && ZSH_THEME="gentoo"

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
plugins=(zsh-completions zsh-syntax-highlighting zsh-autosuggestions) # zsh-autosuggestions docker docker-compose git

[ -s $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

# User configuration
# (figlet -f slant 'Rock & Code' && fortune -s)|lolcat;

HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
HISTORY_IGNORE="(cd|cd ..*|ps|ls|la|l|ll|pwd|clear|reset|man *|history*|vim|vi|nvim)"

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

# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bindkey -s "^[r" " nvim \"+normal G\" ~/.zsh_history^M"; fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# alias vim=nvim
alias reset='tput reset'
alias cmds='history | awk '\''{print $2}'\'' | sort | uniq -c | sort -nr | head -n 6'
alias bat='bat --style=plain --paging=never --color=always'
alias jo='joshuto-func'
alias lg='lazygit'
#alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

function joshuto-func() {
	ID="$$"
	mkdir -p /tmp/$USER
	OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID"
	env joshuto --output-file "$OUTPUT_FILE" $@
	exit_code=$?

	case "$exit_code" in
		# regular exit
		0)
			;;
		# output contains current directory
		101)
			JOSHUTO_CWD=$(cat "$OUTPUT_FILE")
			cd "$JOSHUTO_CWD"
			;;
		# output selected files
		102)
			;;
		*)
			echo "Exit code: $exit_code"
			;;
	esac
}

function reset-prompt-and-accept-line() {
    reset-prompt
    zle accept-line
    RPROMPT='%(?..%B(%?%)%b)'
}

# setopt PRINT_EXIT_VALUE

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

zle -N reset-prompt-and-accept-line
zle -N reset-prompt-and-accept-and-hold
zle -N reset-prompt-and-accept-and-down-history
bindkey '^M' reset-prompt-and-accept-line
bindkey '^[a' reset-prompt-and-accept-and-hold
bindkey '^o' reset-prompt-and-accept-and-down-history
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-line
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-and-hold
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-and-down-history

bindkey '^[l' down-case-word
#bindkey '^W' vi-backward-kill-word
#bindkey '^[^?' vi-backward-kill-word

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

  # if (( exit_code != 0)) then
  #   printf "${GRAY}error code: $return_code${NC}\n"
  # fi
}

# TRAPERR() print -u2 exit code $?

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

function colors() {
  for i in {0..255};
  do
    printf "\x1b[38;5;${i}m${i} ";
  done
  printf "\n";
}

function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 5); do time $shell -i -c exit; done
}

# fglog - git log browser with FZF
function fglog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

function omzu() {
    printf "\x1b[38;5;117m%s\033[0m\n" "Updating custom omz plugins"
    for plugin in ~/.oh-my-zsh/custom/plugins/*/; do
        if [ -d "$plugin/.git" ]; then
            printf "${YELLOW}%s${RESET}\n" "${plugin%/}"
            git -C "$plugin" pull
        fi
    done
    omz update
}
# zprof|head

# fzf/rg
if (( $+commands[rg] )) then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

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
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"


# FZF keybindings
(($+commands[fzf] && $+commands[rg])) && source $DOTFILES/zsh-files/key-bindings-fzf.zsh

# Skim keybindings
# (($+commands[sk] && $+commands[rg])) && source $DOTFILES/zsh-files/key-bindings-skim.zsh
# if (($+commands[rg] && $+commands[fd])) then
#   export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
#   export SKIM_CTRL_R_OPTS="--color=fg:243,fg+:255,current_match_bg:239,hl:3,hl+:2,matched_bg:-1"
#   export SKIM_CTRL_T_OPTS="--color=fg:243,fg+:255,current_match_bg:239,hl:3,hl+:2,matched_bg:-1"
# fi

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
