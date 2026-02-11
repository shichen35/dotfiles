#!/usr/bin/env zsh

set -eo pipefail

OMZ_DIR="$HOME/.oh-my-zsh"
OMZ_CUSTOM="${ZSH_CUSTOM:-$OMZ_DIR/custom}"

clone_if_missing() {
    local repo="$1"
    local dst="$2"
    local depth="${3:-1}"
    if [[ ! -d "$dst" ]]; then
        git clone --depth="$depth" "$repo" "$dst"
    fi
}

# install oh-my-zsh & plugins
if [[ ! -d "$OMZ_DIR" ]]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions" "$OMZ_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing "https://github.com/jeffreytse/zsh-vi-mode" "$OMZ_CUSTOM/plugins/zsh-vi-mode"
clone_if_missing "https://github.com/Aloxaf/fzf-tab" "$OMZ_CUSTOM/plugins/fzf-tab"
# if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-completions ]; then
#     git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
# fi
# if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete ]; then
#     git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
# fi

# backup and copy .zshrc
if [[ -f "$HOME/.zshrc.pre-oh-my-zsh" && -f "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
    mv "$HOME/.zshrc.pre-oh-my-zsh" "$HOME/.zshrc"
    echo "zshrc file copied! Original .zshrc was replaced to .zshrc.backup"
fi

source "$HOME/.zshrc"

echo "zsh installation finished!"

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
echo "tmux-tpm installation finished!"
