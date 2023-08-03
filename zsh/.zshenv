export DOTFILES=$HOME/.dotfiles
export TERMINFO=$HOME/../usr/share/terminfo
# export GOPATH=$HOME/go
export PATH=$HOME/.local/bin:$PATH
case ${OSTYPE} in
    darwin*)
        BREW_BIN="/usr/local/bin/brew"
        if [ -f "/opt/homebrew/bin/brew" ]; then
            BREW_BIN="/opt/homebrew/bin/brew"
        fi

        if type "${BREW_BIN}" &> /dev/null; then
            export BREW_PREFIX="$("${BREW_BIN}" --prefix)"
            for bindir in "${BREW_PREFIX}/opt/"*"/libexec/gnubin"; do export PATH=$bindir:$PATH; done
            for bindir in "${BREW_PREFIX}/opt/"*"/bin"; do export PATH=$bindir:$PATH; done
            for mandir in "${BREW_PREFIX}/opt/"*"/libexec/gnuman"; do export MANPATH=$mandir:$MANPATH; done
            for mandir in "${BREW_PREFIX}/opt/"*"/share/man/man1"; do export MANPATH=$mandir:$MANPATH; done
        fi
        ;;
    linux*)
        export PATH=$PATH:/usr/games
        ;;
esac
export PATH=$PATH:$HOME/.cargo/bin
# export PATH=$PATH:/snap/bin:$HOME/.local/bin
# export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin;
# export PATH=$PATH:/usr/local/go/bin:/snap/bin:$HOME/.local/bin;

# Colorizing pager for man, by setting the MANPAGER environment variable
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export TIMEFMT=$'=============\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
