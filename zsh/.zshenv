export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export VISUAL="nvim"
export EDITOR=$VISUAL

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles
export TERMINFO=$HOME/../usr/share/terminfo
# export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin
case ${OSTYPE} in
  darwin*)
    source $DOTFILES/zsh-files/mac.zsh
    ;;
  linux*)
    export PATH=$PATH:/usr/games
    ;;
esac
export PATH=$PATH:$HOME/.cargo/bin
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# export PATH=$PATH:/snap/bin:$HOME/.local/bin
# export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin;
# export PATH=$PATH:/usr/local/go/bin:/snap/bin:$HOME/.local/bin;

# Colorizing pager for man, by setting the MANPAGER environment variable
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export TIMEFMT=$'=============\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

