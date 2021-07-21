# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
#
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export VISUAL="vim"
export EDITOR="$VISUAL"
# export PATH=$PATH:/snap/bin:$HOME/.local/bin
# export PATH=$PATH:/usr/local/go/bin:/snap/bin:$HOME/.local/bin;

#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="gentoo"
# ZSH_THEME="agnoster"

TIMEFMT=$'=============\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-completions zsh-autosuggestions)  # docker docker-compose

source $ZSH/oh-my-zsh.sh
# FZF keybindings
source "/usr/share/doc/fzf/examples/key-bindings.zsh"

# User configuration
printf "$(figlet -f slant 'Rock & Code')\n$(fortune -s)\n" | lolcat;

# Colorizing pager for man, by setting the MANPAGER environment variable
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000
#HISTORY_IGNORE="(cd|cd ..*|ps|ls|la|l|ll|pwd|clear|reset|man *|history*|vim|vi|nvim)"

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


# ensure synchronization between Bash memory and history file
# export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bindkey -s "^[r" " vim \"+normal G\" ~/.zsh_history^M"; fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_USE_ASYNC=YES
#autoload -Uz compinit && compinit -i


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias reset='tput reset'
alias cmds='history | awk '\''{print $2}'\'' | sort | uniq -c | sort -nr | head -n 6'
alias bat='bat --style=plain --paging=never --color=always'
#alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

reset-prompt-and-accept-line() {
    if [ -n "${BUFFER##*( )}" ]; then
        OLD_PROMPT="$PROMPT"
        PROMPT='%{%F{245}%}[%D{%H:%M:%S}]>%f '
        zle reset-prompt
        PROMPT="$OLD_PROMPT"
    fi
    zle accept-line
}
zle -N reset-prompt-and-accept-line
bindkey '^M' reset-prompt-and-accept-line
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt-and-accept-line

bindkey '^[l' down-case-word
#bindkey '^W' vi-backward-kill-word
#bindkey '^[^?' vi-backward-kill-word

# This function is executed before the command line is written to history. If it does return 1, the current command line is neither appended to the history file nor to the local history stack.
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

vdiff () {
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

colors() {
  for i in {0..255};
  do
    printf "\x1b[38;5;${i}m${i} ";
  done
  printf "\b";
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# zprof|head
