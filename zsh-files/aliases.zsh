# =============================================================================
# ALIASES
# =============================================================================
alias reset='tput reset'
alias cmds='history | awk '''{print $2}''' | sort | uniq -c | sort -nr | head -n 6'
alias eh="$EDITOR "+normal G" ~/.zsh_history"
alias lg='lazygit'
alias lzd='lazydocker'
alias la='ls -lah'
alias lastmod='fd --no-ignore -t f -0 | xargs -0 ls -lrt --color=auto | tail -n 10'

# Use wezterm fallback if not defined
((!$+commands[wezterm])) && alias wezterm='flatpak run org.wezfurlong.wezterm'

# Git Aliases
alias ga="git add"
alias gb="git branch"
alias gch="git checkout"
alias gc="git commit"
alias gca="git commit --amend"
alias gd="git diff"
alias gds="git diff --staged"
alias glg="git log --all --oneline --graph --decorate"
alias gpl="git pull --prune"
alias gps="git push --no-verify"
alias gm="git merge"
alias gs="git status"
alias gss="git status -sb"
alias gsw="git switch"
alias grs="git restore --staged"
