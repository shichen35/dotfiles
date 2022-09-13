. "$HOME/.cargo/env"

export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export VISUAL="vim"
export EDITOR="$VISUAL"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES="$HOME/.dotfiles"
# export GOPATH=$HOME/go
case ${OSTYPE} in
  darwin*)
    source $DOTFILES/zsh-files/mac.zsh
    ;;
  linux*)
    export PATH=$PATH:/usr/games/;
    ;;
esac
# export PATH=$PATH:/snap/bin:$HOME/.local/bin
# export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin;
# export PATH=$PATH:/usr/local/go/bin:/snap/bin:$HOME/.local/bin;

# Colorizing pager for man, by setting the MANPAGER environment variable
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export TIMEFMT=$'=============\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# fzf
if type rg &> /dev/null; then
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

# export FZF_TMUX_OPTS="-p"
