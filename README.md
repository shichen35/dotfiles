# dotfiles

## Distrobox
Opening links from inside container on host:
```bash
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/xdg-open
sudo ln -s /usr/bin/distrobox-host-exec /usr/bin/dolphin
```

```bash
pacman -Qe | awk '{print $1}' > package_list.txt
for x in $(cat package_list.txt); do pacman -S $x; done
```
Prerequisites:

    - git
    - curl
    - wget
    - zsh
    - tmux
    - neovim
    - n nodejs
    - python3 python3-pip

