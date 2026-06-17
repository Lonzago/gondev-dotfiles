# Neovim Configuration

Based on **LazyVim v8** with custom overrides.

## Quick Reference

| What | How |
|------|-----|
| Escape | `jk` or `kj` |
| Manual completion | `Ctrl+Enter` or `Alt+Space` |
| Reload theme | `:LazyReload` |
| Open dir in nvim | `n` (zsh alias) |

## Keybindings

### Insert Mode

| Key | Action |
|-----|--------|
| `jk` | Escape (like jk in vim) |
| `kj` | Escape (alternative) |
| `Ctrl+Enter` | Manual blink.cmp completion |
| `Alt+Space` | Manual blink.cmp completion |

### Normal Mode

Standard LazyVim keybindings apply. Key ones:

- `Space` — leader key
- `<leader>ff` — find files (Telescope)
- `<leader>fg` — live grep
- `<leader>fb` — buffers
- `<leader>fc` — git commits
- `<leader>fh` — help tags
- `Ctrl+\` — terminal toggle
- `gcc` — comment toggle

## Auto-Completion

**blink.cmp** is configured in **manual-only mode**:

- Auto-trigger disabled (typing doesn't trigger suggestions)
- Menu auto-show disabled
- Trigger manually with `Ctrl+Enter` or `Alt+Space`

This prevents annoying popups while typing. If you want auto-completion back, edit `lua/plugins/blink-override.lua` and set:
```lua
trigger = {
  show_on_keyword = true,
  show_on_trigger_character = true,
}
```

## Theme & Transparency

### Current Theme

Default is **omarchy** theme (follows system). Configured in LazyVim extras.

### Changing Theme

1. Open LazyVim dashboard (`<leader>pm`)
2. Select "Extras" → "Extras"
3. Choose a colorscheme (e.g., `tokyonight`, `gruvbox`, `catppuccin`)
4. Restart Neovim or run `:LazyReload`

### Transparency

Enabled to work with **Kitty terminal opacity**. See `plugin/after/transparency.lua`.

This makes the following highlight groups transparent:
- Normal, FloatBorder, Pmenu
- Telescope UI elements
- NeoTree
- Notify (nvim-notify)

If transparency breaks after a plugin update, check this file.

### Hot Reload Theme

Run `:LazyReload` to apply a new theme without restarting Neovim. This:
1. Clears old highlight groups
2. Loads new colorscheme
3. Re-applies transparency

## Plugins

Core plugins (managed via LazyVim):

| Plugin | Purpose |
|--------|---------|
| blink.cmp | Auto-completion (manual mode) |
| telescope | Fuzzy finder, grep, etc. |
| treesitter | Syntax highlighting |
| neo-tree | File tree |
| lsp-config | Language servers |
| mason | LSP installer |
| spectre | Find & replace |
| snacks | UI animations |

Extra plugins in `lua/plugins/`:
- `all-themes.lua` — theme switching
- `omarchy-theme-hotreload.lua` — theme reload
- `disable-news-alert.lua` — hide LazyVim news
- `spectre.lua` — find & replace
- `snacks-animated-scrolling-off.lua` — disable scrolling animation
- `unreal-plugins.lua` — Unreal Engine plugins (requires UNL build + fd/rg for UEP; keep `neo-tree-unl.nvim` only if you want the legacy explorer hook)
- `unreal-plugins.lua` — UnrealDev.nvim wrapper plus Unreal parsers; requires the UNL scanner build and tree-sitter-manager
- `lsp-config.lua` — LSP servers including GDScript

Helper scripts:
- `bin/.local/bin/ue-unlrc` — creates `.unlrc.json` for a project by resolving the matching Unreal Engine path


### Unreal Engine Plugins

The Unreal bundle now uses `taku25/UnrealDev.nvim` as a wrapper in `lua/plugins/unreal-plugins.lua`. It pulls in the suite plugins you enable through `setup_modules`.

Requirements:
- `cargo` for `taku25/UNL.nvim` (build: `cargo build --release --manifest-path scanner/Cargo.toml`)
- `fd` for file discovery
- `rg` (ripgrep) for text search
- `tree-sitter-manager.nvim` for Unreal parser installation

Current enabled modules:
- `UBT`
- `UEP`
- `ULG`
- `UCM`
- `UNX`

Disabled in the wrapper config for now:
- `USH`
- `UEA`
- `UDB`

Note: `neo-tree-unl.nvim` is legacy/archived; the current setup favors `UNX.nvim`.

To disable the Unreal bundle temporarily, make `lua/plugins/unreal-plugins.lua` return `{}` and run `:Lazy`.

Health check follow-up:
- If `:checkhealth UnrealDev` reports a missing UNL scanner, build it in the `UNL.nvim` plugin directory with `cargo build --release --manifest-path scanner/Cargo.toml`.
- If tree-sitter-manager is missing, install it through `:Lazy` and rerun the health check.

## LSP & Languages

Languages are managed via **mason** and **lsp-config**. To install a language server:

1. `:Mason` — open Mason UI
2. Navigate to LSP/linter/formatter
3. Press `i` to install

Or install via terminal:
```bash
nvim --headless +MasonInstall rust_analyzer ts_ls eslintDjango
```

Godot support currently covers `.gd` files via `gdscript` filetype mapping and the `gdscript` LSP server.

## Configuration Files

| File | Purpose |
|------|---------|
| `init.lua` | Entry point, bootstraps lazy.nvim |
| `lua/config/lazy.lua` | LazyVim plugin setup |
| `lua/config/options.lua` | vim.opt overrides |
| `lua/config/keymaps.lua` | Custom keymaps |
| `lua/config/autocmds.lua` | Autocommands |
| `lua/plugins/*.lua` | Plugin configurations |

## Troubleshooting

### Plugin not loading
Run `:Lazy` to see plugin status.

### LSP not working
- Run `:LspInfo` to check status
- Run `:LspRestart` to reload
- Check `:Mason` to ensure language server is installed

### Theme colors broken
- Run `:LazyReload` to reapply
- Check `plugin/after/transparency.lua` for errors

### Transparency not working
- Verify Kitty has opacity set (`background_opacity 0.5`)
- Check that `lua/plugins/omarchy-theme-hotreload.lua` loaded

## Resources

- [LazyVim Docs](https://lazyvim.github.io)
- [Neovim Docs](https://neovim.io/doc)
- [blink.cmp](https://github.com/saghen/blink.cmp)
