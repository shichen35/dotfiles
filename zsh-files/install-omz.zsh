#!/usr/bin/zsh

# install oh-my-zsh & plugins
if [ ! -d $HOME/.oh-my-zsh ]; then
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-completions ]; then
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

# backup and copy .zshrc
if [ -f $HOME/.zshrc.pre-oh-my-zsh ] && [ -f $HOME/.zshrc ]; then
  mv $HOME/.zshrc $HOME/.zshrc.backup
  mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
  echo "zshrc file copied! Original .zshrc was replaced to .zshrc.backup"
fi

source ~/.zshrc

echo "😇 zsh installation finished!"
