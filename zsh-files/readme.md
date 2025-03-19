# Modify the zsh agnoster theme to show only the current directory name

File: `~/.oh-my-zsh/themes/agnoster.zsh-theme`

Replace the following code:

```bash
# Dir: current working directory
prompt_dir() {
  if [[ $AGNOSTER_GIT_INLINE == 'true' ]] && $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    # Git repo and inline path enabled, hence only show the git root
    prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" "$(git_toplevel | sed "s:^$HOME:~:")"
  else
    prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" '%~'
  fi
}
```

with the following code:

```bash
# Dir: current working directory
prompt_dir() {
  if [[ $AGNOSTER_GIT_INLINE == 'true' ]] && $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    # Git repo and inline path enabled, hence only show the git root
    prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" "$(git_toplevel | sed "s:^$HOME:~:")"
  else
     # Show current directory only, but still show ~ for home
    if [[ $PWD == $HOME ]]; then
      prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" "~"
    else
      prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" "$(basename $PWD)"
    fi
  fi
}
```

# Modify the zsh agnoster theme to not show the hostname



Replace the following code:

```bash
# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment "$AGNOSTER_CONTEXT_BG" "$AGNOSTER_CONTEXT_FG" "%(!.%{%F{$AGNOSTER_STATUS_ROOT_FG}%}.)%n@%m"
  fi
}
```

with the following code:

```bash
# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment "$AGNOSTER_CONTEXT_BG" "$AGNOSTER_CONTEXT_FG" "%(!.%{%F{$AGNOSTER_STATUS_ROOT_FG}%}.)%n"
  fi
}
```