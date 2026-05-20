# gondev-dotfiles

This is a Hyprland + Omarchy dotfiles repository managed with GNU Stow.

## Workflow Rules

- **Before commits**: ALWAYS show the changes and ask the user before committing. Wait for explicit confirmation ("yes", "si", "confirm", etc.) before executing each commit.
- **No auto-commits**: Do not commit without explicit permission.

## Deployment

```bash
# Preferred: deploy with automatic backup of existing configs
./scripts/stow-deploy.sh

# Preview what would happen (no changes)
./scripts/stow-deploy.sh --dry-run

# Manual stow (if you prefer)
stow -t ~ .

# Deploy specific package (run from dotfiles root)
cd hypr && stow -t ~/.config hypr
```

**Note**: `stow-deploy.sh` backs up existing configs to `.bak` before stowing.

## Directory Structure

| Directory | Target | Notes |
|-----------|--------|-------|
| `bin/` | `~/.local/bin/` | User command scripts deployed via stow |
| `hypr/` | `~/.config/hypr/` | Hyprland window manager |
| `nvim/` | `~/.config/nvim/` | LazyVim Neovim config |
| `kitty/` | `~/.config/kitty/` | Terminal emulator |
| `waybar/` | `~/.config/waybar/` | Status bar |
| `walker/` | `~/.config/walker/` | App launcher |
| `yazi/` | `~/.config/yazi/` | File manager |
| `fastfetch/` | `~/.config/fastfetch/` | System info display |
| `zsh/` | `~/.config/zsh/` | Shell config (zshrc, plugins, fzf, bindings) |
| `nvim/` | `~/.config/nvim/` | LazyVim Neovim config, including UnrealDev.nvim wrapper and parser setup |
| `bin/` | `~/.local/bin/` | User scripts, including Unreal launcher and `.unlrc.json` generator |

**Ignored by stow**: `scripts/`, `keyboard/` (not deployed)

## Tech Stack

- **Window Manager**: Hyprland with Omarchy config system
- **Terminal**: Kitty (theme sourced from omarchy)
- **Shell**: zsh + Oh My Zsh + zsh-autosuggestions + zsh-syntax-highlighting
- **Prompt**: Starship
- **File Manager**: Yazi
- **App Launcher**: Walker
- **Neovim**: LazyVim (v8)
- **Status Bar**: Waybar

## Key Configuration Notes

1. **Hyprland**: `hyprland.conf` sources `hypr-omarchy.conf` which loads the omarchy theme from `~/.config/omarchy/current/theme/hyprland.conf`
2. **Kitty**: `kitty.conf` sources omarchy theme via `include ~/.config/omarchy/current/theme/kitty.conf`
3. **Waybar**: Heavily integrated with omarchy commands (`omarchy-menu`, `omarchy-update`, etc.)
4. **Walker**: Uses omarchy theme and default configuration

## Important zsh Aliases

- `oc` → opencode
- `lg` → lazygit
- `ld` → lazydocker
- `t` → tmux attach or new session
- `n` → nvim (opens directory if no args)
- `g` → git
- `ff` → fzf with image preview (kitty) or bat preview
- `zd` → zoxide cd replacement

## Zsh Configuration

### Plugin Loading
Uses `zsh/plugins.zsh` with auto-install from GitHub:
- `zsh-users/zsh-autosuggestions`
- `zsh-users/zsh-syntax-highlighting`
- `zsh-users/zsh-history-substring-search`
- `jeffreytse/zsh-vi-mode`
- `zdharma-continuum/fast-syntax-highlighting`

Plus oh-my-zsh built-ins: `colored-man-pages`, `sudo`, `archlinux`

Run `zplugin-update` to update all plugins.

### History
- 100k commands saved
- Share history between sessions
- Ignore duplicates and spaces

### FZF Keybindings
- `Ctrl+T` — file picker with bat preview
- `Ctrl+R` — history search
- `Ctrl+F` — file picker (no hidden files)
- `Ctrl+Left/Right` — word navigation
- `Up/Down` — history substring search

### Vi-mode
Enhanced zsh-vi-mode with visual indicators for Normal/Insert mode.

## Neovim (LazyVim v8)

- **Auto-completion disabled** — blink.cmp only triggers manually with `Ctrl+Enter` or `Alt+Space`
- **Keymaps**: `jk` or `kj` → escape
- **Transparency** enabled for terminal background (works with Kitty opacity)
- **Theme hot-reload** — `:LazyReload` restarts theme without restarting Neovim
- **Details**: see `nvim/README.md`
- **Plugin management**: use skill `nvim-plugins` for adding/removing/modifying plugins

## Project Skills

- `nvim-plugins` — add, remove, or modify Neovim plugins (LazyVim)

## Installation Script

`scripts/install-hypr-arch.sh` is the Arch Linux setup script. It installs:
- Hyprland, waybar, fastfetch, rofi
- neovim, kitty, zsh, ffmpeg
- AUR packages: swww, waypaper via yay

Not deployed via stow — run manually on fresh install.

## Adding New Packages

When adding a new config folder, the AI must update:

1. **`scripts/stow-deploy.sh`** — Add the new package to the `PACKAGES` array:
   ```bash
   "nueva_carpeta:.config:nueva_carpeta"
   ```
   Format: `"name:target_parent:target_name"` where:
   - `name` = folder name in dotfiles repo
   - `target_parent` = `~` for home (e.g. `.zshrc`) or `.config` for `~/.config/`
   - `target_name` = destination folder/file name

2. **`AGENTS.md`** — Add row to Directory Structure table with target path and description

3. **`README.md`** — Add row to What's Included table

4. **`.stow-local-ignore`** — Ensure the new folder is NOT ignored if it's a config to deploy

**DO NOT create new documentation files.** Update these existing files instead.
