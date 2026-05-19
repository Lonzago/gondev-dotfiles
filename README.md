# gondev-dotfiles

My Hyprland + Omarchy dotfiles managed with GNU Stow.

## Quick Start

```bash
# Clone and deploy everything (with automatic backup)
git clone https://github.com/Lonzago/gondev-dotfiles.git
cd gondev-dotfiles
./scripts/stow-deploy.sh

# Preview what would happen (no changes)
./scripts/stow-deploy.sh --dry-run
```

## What's Included

| Package | Target | Description |
|---------|--------|-------------|
| `bin/` | `~/.local/bin/` | User command scripts, including launcher helpers |
| `hypr/` | `~/.config/hypr/` | Hyprland window manager config |
| `nvim/` | `~/.config/nvim/` | LazyVim Neovim setup |
| `kitty/` | `~/.config/kitty/` | Terminal emulator |
| `waybar/` | `~/.config/waybar/` | Status bar |
| `walker/` | `~/.config/walker/` | App launcher |
| `yazi/` | `~/.config/yazi/` | File manager |
| `fastfetch/` | `~/.config/fastfetch/` | System info display |
| `zsh/` | `~/.zshrc` | Shell configuration |

## Tech Stack

- **WM**: Hyprland with [Omarchy](https://github.com/chmrr1/omarchy) theming
- **Terminal**: Kitty with omarchy theme
- **Shell**: zsh + Oh My Zsh + starship prompt
- **Editor**: LazyVim (Neovim v8)
- **Launcher**: Walker
- **File Manager**: Yazi

## Key Aliases

Once deployed, these shortcuts are available in zsh:

- `oc` — opencode
- `lg` — lazygit
- `ld` — lazydocker
- `t` — tmux attach or new session
- `n` — nvim (opens current dir if no args)
- `g` — git
- `ff` — fzf with image preview (kitty icat) or bat
- `zd` — zoxide cd replacement

## Zsh Configuration

### Plugins
Uses custom `plugins.zsh` with auto-install:
- **zsh-autosuggestions** — sugerencias basadas en historial
- **zsh-syntax-highlighting** — highlight de comandos en tiempo real
- **zsh-history-substring-search** — buscar en historial con arrows
- **zsh-vi-mode** — enhanced vi-mode con indicadores de modo
- **fast-syntax-highlighting** — syntax highlighting avanzado
- Plus: colored-man-pages, sudo, archlinux (oh-my-zsh)

Run `zplugin-update` to update plugins.

### FZF Keybindings
- `Ctrl+T` — file picker con preview de bat
- `Ctrl+R` — buscar en historial
- `Ctrl+F` — file picker (sin archivos ocultos)
- `Ctrl+Left/Right` — mover por palabras
- `Up/Down` — historial por substring

## Fresh Install (Arch Linux)

Run the setup script on a new Arch system:

```bash
curl -fsSL https://github.com/Lonzago/gondev-dotfiles/blob/main/scripts/install-hypr-arch.sh | bash
```

This installs:
- Hyprland, Waybar, Fastfetch, Rofi
- Neovim, Kitty, zsh, ffmpeg
- AUR packages: swww, waypaper (via yay)

## Notes

- `scripts/` and `keyboard/` are **not** deployed via stow — they're manual
- Hyprland config sources `hypr-omarchy.conf` which pulls the omarchy theme from `~/.config/omarchy/current/theme/`
- Some configs depend on omarchy being installed separately

## Repository

- Remote: `https://github.com/Lonzago/gondev-dotfiles.git`
- Branch: `main`
