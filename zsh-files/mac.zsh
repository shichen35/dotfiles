# =============================================================================
# macOS specific shell configuration.
#
# One-time system preferences (`defaults write`) are NOT here: they live in
# macos-defaults.sh, which installs.zsh runs once during setup. Running them on
# every shell start spawned four processes per terminal for no benefit.
#
# SDKMAN is initialised in work.zsh, which is sourced on every platform.
# =============================================================================

export ANSIBLE_VAULT_PASSWORD_FILE=/Users/chen.shi/Developer/ansible-vault.pass

alias wpm='wpm --tag chen'
alias wpms='wpm --stats'

path_prepend "/usr/local/opt/openssl@1.1/bin"
