# =============================================================================
# Toolchains and version managers.
# Machine-specific paths and aliases belong in ~/.zshrc.local instead.
# path_prepend / path_append are defined in .zshrc, which sources this file.
# =============================================================================

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export DefaultIMModule=fcitx

# -----------------------------------------------------------------------------
# bun
# -----------------------------------------------------------------------------
if [[ -x "$HOME/.bun/bin/bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    path_prepend "$BUN_INSTALL/bin"
    [[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
fi

# -----------------------------------------------------------------------------
# pnpm
# -----------------------------------------------------------------------------
export PNPM_HOME="$HOME/.local/share/pnpm"
path_prepend "$PNPM_HOME"

# -----------------------------------------------------------------------------
# deno
# -----------------------------------------------------------------------------
[[ -s "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

# -----------------------------------------------------------------------------
# neovim tarball install, android platform-tools, local homebrew
# -----------------------------------------------------------------------------
path_append "/opt/nvim-linux-x86_64/bin" "$HOME/.local/platform-tools"
path_prepend "$HOME/homebrew/bin"

# -----------------------------------------------------------------------------
# conda / mamba: on demand only. Run `condainit` when you need them.
# -----------------------------------------------------------------------------
function condainit {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
local __conda_setup
if [[ -x "$HOME/miniforge3/bin/conda" ]]; then
    __conda_setup="$("$HOME/miniforge3/bin/conda" shell.zsh hook 2> /dev/null)"
fi
if [[ $? -eq 0 && -n "$__conda_setup" ]]; then
    eval "$__conda_setup"
else
    if [[ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]]; then
        source "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        path_prepend "$HOME/miniforge3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
local __mamba_setup
export MAMBA_EXE="$HOME/miniforge3/bin/mamba"
export MAMBA_ROOT_PREFIX="$HOME/miniforge3"
if [[ -x "$MAMBA_EXE" ]]; then
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
fi
if [[ $? -eq 0 && -n "$__mamba_setup" ]]; then
    eval "$__mamba_setup"
elif [[ -x "$MAMBA_EXE" ]]; then
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
}

# -----------------------------------------------------------------------------
# nvm, loaded lazily.
#
# Sourcing nvm.sh normally costs ~0.5s, almost all of it activating the default
# version. So instead: put the default version's bin directory straight on PATH
# (node, npm and npx are then real binaries with no wrapper), and only source
# nvm.sh when the `nvm` command itself is used or a directory carries a .nvmrc.
# -----------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    typeset -g _nvm_loaded=0
    typeset -g _nvm_rc_active=0
    typeset -g _nvm_resolved=""
    typeset -g _nvm_current=""

    # Resolve a version spec (alias name, partial version, or vX.Y.Z) to an
    # installed version directory, following alias chains such as
    # default -> 26 or lts/* -> lts/krypton -> v24.19.0. Sets _nvm_resolved.
    # Pure zsh, no subprocesses: about 0.02ms.
    _nvm_resolve() {
        emulate -L zsh
        setopt noglob
        local version=$1 guard=0
        _nvm_resolved=""
        [[ -n $version ]] || return 1
        while [[ -r $NVM_DIR/alias/$version ]] && (( guard++ < 10 )); do
            IFS= read -r version < $NVM_DIR/alias/$version || break
        done
        unsetopt noglob
        local -a dirs
        dirs=($NVM_DIR/versions/node/v${version#v}*(Nn))
        (( $#dirs )) || return 1
        _nvm_resolved=${dirs[-1]}
    }

    # Which version is active right now, read straight off PATH. No subprocesses.
    _nvm_active() {
        local p
        _nvm_current=""
        for p in $path; do
            if [[ $p == $NVM_DIR/versions/node/*/bin ]]; then
                _nvm_current=${p%/bin}
                return 0
            fi
        done
        return 1
    }

    # Put the default version on PATH directly, so node/npm/npx are real
    # binaries from the first prompt without nvm.sh being sourced at all.
    _nvm_resolve default && path_prepend "$_nvm_resolved/bin"

    # Source nvm.sh once, on first real need. --no-use because PATH is already set.
    _nvm_load() {
        (( _nvm_loaded )) && return 0
        _nvm_loaded=1
        unfunction nvm 2>/dev/null
        source "$NVM_DIR/nvm.sh" --no-use
        [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    }

    # Stub: the first `nvm ...` call pays the load cost, later ones do not.
    nvm() {
        _nvm_load
        nvm "$@"
    }

    # .nvmrc auto-switching.
    # `nvm use` costs about half a second, so it only runs when the version
    # actually has to change. Finding the file and comparing versions is done
    # without forking, which keeps an ordinary cd free.
    _nvm_auto_switch() {
        local dir=$PWD rc="" spec="" want=""

        while [[ -n $dir ]]; do
            [[ -f $dir/.nvmrc ]] && { rc=$dir/.nvmrc; break; }
            dir=${dir%/*}
        done

        if [[ -n $rc ]]; then
            IFS= read -r spec < $rc 2>/dev/null
            spec=${spec//[[:space:]]/}
            _nvm_resolve "$spec" && want=$_nvm_resolved
            _nvm_rc_active=1
        elif (( _nvm_rc_active )); then
            _nvm_resolve default && want=$_nvm_resolved
            _nvm_rc_active=0
        else
            return 0
        fi

        _nvm_active
        # Already on the wanted version: no work, and nvm stays unloaded.
        [[ -n $want && $want == $_nvm_current ]] && return 0

        _nvm_load
        if [[ -n $rc ]]; then
            # --silent prints nothing at all, not even on failure, so say it here.
            nvm use --silent || print -u2 "nvm: $rc asks for '$spec', which is not installed. Run \`nvm install\` here."
        else
            nvm use --silent default >/dev/null 2>&1
        fi
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd _nvm_auto_switch
    _nvm_auto_switch
fi

# -----------------------------------------------------------------------------
# SDKMAN. This must stay at the end of the file: its init script rewrites PATH
# and expects to have the last word.
# -----------------------------------------------------------------------------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
