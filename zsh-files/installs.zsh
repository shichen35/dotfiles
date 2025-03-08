#!/bin/zsh

# install oh-my-zsh & plugins
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode ]; then
    git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
fi
# if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete ]; then
#     git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
# fi

# backup and copy .zshrc
if [ -f $HOME/.zshrc.pre-oh-my-zsh ] && [ -f $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc.backup
    mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
    echo "zshrc file copied! Original .zshrc was replaced to .zshrc.backup"
fi

source ~/.zshrc

echo "😇 zsh installation finished!"

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "😇 tmux-tpm installation finished!"
