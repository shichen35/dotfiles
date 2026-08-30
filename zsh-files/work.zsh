# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export DefaultIMModule=fcitx

typeset -U path PATH

path_prepend() {
  local p
  for p in "$@"; do
    [[ -n "$p" ]] && path=("$p" $path)
  done
}

path_append() {
  local p
  for p in "$@"; do
    [[ -n "$p" ]] && path+=("$p")
  done
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

if [[ -x "$HOME/.bun/bin/bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    path_prepend "$BUN_INSTALL/bin"

    # bun completions
    [[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
fi

# export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

path_append "/opt/nvim-linux-x86_64/bin" "$HOME/.local/platform-tools"
path_prepend "$HOME/homebrew/bin"
[[ -s "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

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

# pnpm
export PNPM_HOME="/home/chenshi/.local/share/pnpm"
path_prepend "$PNPM_HOME"
# pnpm end

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##############################
# local
##############################
[[ -x "/home/chenshi/AppImages/cursor.appimage" ]] && alias cursor="/home/chenshi/AppImages/cursor.appimage"

export ANDROID_HOME="$HOME/Android/Sdk"
path_append "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools"
