# Linux Notes

## Distrobox

Opening links from inside container on host:

### Export binaries to host

```bash
sudo ln -s /usr/bin/distrobox-host-exec /usr/local/bin/xdg-open
sudo ln -s /usr/bin/distrobox-host-exec /usr/bin/dolphin
```

### Backup and Restore pacman packages

```bash
pacman -Qe | awk '{print $1}' > package_list.txt
for x in $(cat package_list.txt); do pacman -S $x; done
```
