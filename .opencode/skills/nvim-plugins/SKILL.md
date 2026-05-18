---
name: nvim-plugins
description: "Trigger: add nvim plugin, remove nvim plugin, modify nvim plugin, install plugin neovim. Add, remove, or modify LazyVim plugins in this dotfiles repo."
license: Apache-2.0
metadata:
  author: gondev
  version: "1.0"
---

## Activation Contract

This skill activates when working with Neovim plugin management in this dotfiles repository. It covers adding new plugins, removing existing ones, and modifying plugin configurations.

## Hard Rules

- **ALWAYS check if related config already exists first** — do not create new files if you can modify existing ones
- Plugins live in `nvim/.config/nvim/lua/plugins/*.lua`
- Each file exports a plugin spec via `return { "owner/repo", opts = {...} }`
- Always run `:Lazy` after changes to sync plugins
- Do NOT modify `lazy-lock.json` — it's auto-generated
- Reference `nvim/README.md` for plugin details

## Decision Gates

| Task | Action |
|------|--------|
| Add plugin | Create new file in `lua/plugins/` with plugin spec |
| Remove plugin | Delete the plugin file from `lua/plugins/` |
| Modify config | Edit the existing plugin file's `opts` or add `config` function |
| Disable temporarily | Comment out the plugin spec or add `enabled = false` |
| Update plugin | Delete plugin file, add new version, run `:Lazy` |

## Execution Steps

### Adding a Plugin

0. **Check first**: Search existing files in `lua/plugins/` for related config (e.g., for C++ check `lsp-config.lua` and `treesitter.lua` first)
1. If related config exists → modify that file instead of creating new one
2. Only create new file if no related config exists: `nvim/.config/nvim/lua/plugins/my-plugin.lua`
3. Add the plugin spec:

```lua
return {
  "owner/plugin-name",
  opts = { -- configuration options
    option = value,
  },
  config = function() -- optional: run after load
    -- setup code
  end,
}
```

4. Open Neovim and run `:Lazy` to install

### Removing a Plugin

1. Find the plugin file in `lua/plugins/`
2. Delete the file (or move to `lua/plugins/disabled/` to keep as backup)
3. Run `:Lazy` in Neovim
4. Optionally run `:Lazy clean` to remove plugin data

### Modifying a Plugin

1. Edit the plugin file in `lua/plugins/`
2. Common changes:
   - `opts` — configuration options
   - `config` — setup function
   - `keys` — keybindings
   - `event` — when to load (e.g., `BufRead`)
   - `dependencies` — other plugins needed
3. Run `:Lazy` or restart Neovim

## Common LazyVim Patterns

### Basic Plugin
```lua
return { "plugin-author/plugin-name" }
```

### With Options
```lua
return {
  "plugin-author/plugin-name",
  opts = { option = "value" }
}
```

### With Dependencies
```lua
return {
  "plugin-author/plugin-name",
  dependencies = { "other-plugin" }
}
```

### Conditional Loading
```lua
return {
  "plugin-author/plugin-name",
  enabled = true, -- toggle to disable
}
```

## Output Contract

When modifying plugins, return:
- Files created/deleted/modified
- Any `:Lazy` commands to run
- Changes to documentation (if needed)

## References

- `nvim/.config/nvim/README.md` — detailed Neovim config docs
- `nvim/.config/nvim/lua/plugins/` — existing plugin files
- `nvim/.config/nvim/lazyvim.json` — LazyVim version and extras