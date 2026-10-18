# Windows counterpart of setup.sh: symlinks repo configs to their Windows locations.
# Directories become junctions (no elevation). File entries need Developer Mode or an admin shell.
$ErrorActionPreference = 'Stop'
$D = $PSScriptRoot

Write-Host "Starting Dotfiles Setup (Windows)..."

# target path => repo path
$links = [ordered]@{
  "$env:LOCALAPPDATA\nvim"     = "$D\lvim\.config\nvim"
  # "$env:APPDATA\alacritty"     = "$D\alacritty\.config\alacritty"
  # "$HOME\.config\fastfetch"    = "$D\fastfetch\.config\fastfetch"
  # "$HOME\.clang-format"        = "$D\clang-format\.clang-format"
  # $PROFILE.CurrentUserAllHosts = "$D\powershell\profile.ps1"
}

foreach ($dst in $links.Keys) {
  $src = $links[$dst]
  $item = Get-Item $dst -Force -ErrorAction SilentlyContinue
  if ($item -and -not $item.LinkType) {
    # Same rule as setup.sh: back up real files, replace links
    Write-Host "Backing up existing $dst to $dst.bak"
    Move-Item $dst "$dst.bak"
  } elseif ($item) {
    $item.Delete()  # removes the link only, never the target's contents
  }
  New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
  # Junctions need no elevation; file links still need a symlink
  $type = if (Test-Path $src -PathType Container) { 'Junction' } else { 'SymbolicLink' }
  New-Item -ItemType $type -Path $dst -Target $src | Out-Null
  Write-Host "  - Linked $dst -> $src"
}

Write-Host ">>> Setup Complete!"
