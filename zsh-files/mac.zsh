ZSH_THEME="gentoo"
# ZSH_THEME="gnzh"
# source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# macOS specific configuration
# export MANPATH="/usr/local/man:$MANPATH"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# drag window from anywhere with ctrl + cmd + click
defaults write -g NSWindowShouldDragOnGesture -bool true

export ANSIBLE_VAULT_PASSWORD_FILE=/Users/chen.shi/Developer/ansible-vault.pass

alias wpm='wpm --tag chen'
alias wpms='wpm --stats'
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[ -s $HOME/.sdkman/bin/sdkman-init.sh ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
