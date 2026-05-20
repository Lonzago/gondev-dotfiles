---
title: Configuring Unreal Engine Support in Neovim
tags:
  - nvim
  - unreal-engine
  - obsidian
  - treesitter
  - lazyvim
created: 2026-05-20
updated: 2026-05-20
---

# Configuring Unreal Engine Support in Neovim

This note explains, in plain language, how I turned Neovim into a useful Unreal Engine helper.

I didn’t want “yet another editor setup”. I wanted something that could actually understand an Unreal project, help me move around faster, and stop me from repeating the same boring setup steps every time.

The short version:
- Neovim can understand Unreal projects
- it can find the engine automatically
- it can use Unreal-aware parsing for C++
- it can help with builds, logs, classes, and project navigation

## Goal

Make Neovim work as an Unreal Engine helper with:
- project discovery
- build/navigation tools
- Unreal-specific Tree-sitter parsing
- per-project engine config via `.unlrc.json`

## What each plugin does

Before the config, here’s what the moving parts actually do.

| Plugin | What it does |
|--------|--------------|
| `UnrealDev.nvim` | A wrapper that groups the Unreal tools under one command set (`:UDEV`) |
| `UNL.nvim` | Shared core library used by the Unreal plugins |
| `UEP.nvim` | Finds Unreal project files, modules, classes, and navigation targets |
| `UBT.nvim` | Runs Unreal Build Tool tasks from Neovim |
| `UCM.nvim` | Helps create/manage Unreal C++ classes and file pairs |
| `ULG.nvim` | Reads Unreal logs inside Neovim |
| `UNX.nvim` | Shows a logical Unreal project tree |
| `USX.nvim` | Unreal shader syntax and query support |
| `tree-sitter-manager.nvim` | Installs and manages Tree-sitter parsers |

## What I changed

### 1) Switched to the UnrealDev wrapper

I replaced the old individual Unreal plugin bundle with:
- `taku25/UnrealDev.nvim`

Enabled modules:
- `UBT`
- `UEP`
- `ULG`
- `UCM`
- `UNX`

Left disabled for now:
- `USH`
- `UEA`
- `UDB`

Why this is better:
- one wrapper instead of a pile of disconnected config
- the commands are grouped under `:UDEV`
- the setup is easier to reason about later

In practice, this means I can think in terms of one Unreal toolchain instead of five separate plugins.

### 2) Added the Unreal parser stack

I installed and configured:
- `romus204/tree-sitter-manager.nvim`
- `taku25/tree-sitter-unreal-cpp`
- `taku25/tree-sitter-unreal-shader`
- `taku25/tree-sitter-verse`

What that means in practice:
- C++ files are parsed with Unreal macros in mind
- shader files like `.usf` and `.ush` get proper syntax support
- Verse files can also be handled when needed

This is the part that makes the editor feel “aware” instead of just “colored text”.

I also added filetype mappings for:
- `.usf` → `ushader`
- `.ush` → `ushader`
- `.verse` → `verse`

### 3) Added a project engine helper

I created a helper script:
- `bin/.local/bin/ue-unlrc`

It:
- finds the `.uproject`
- reads `EngineAssociation`
- searches my Unreal engines folder
- writes `.unlrc.json`

Why this helps:
- I don’t have to type the engine path by hand every time
- the project gets a local config file that UnrealDev can read
- it removes one annoying setup step from every new project

It’s a tiny helper, but it saves time every time I start a new project.

### 4) Updated docs

I documented the setup in:
- root `README.md`
- `AGENTS.md`
- `nvim/.config/nvim/README.md`

## Problems I hit

This is the part that usually gets hidden in blog posts, but it’s the useful part.

### Problem 1: `fd` and `rg` were listed like plugins

They are not plugins. They are system tools.

In simple terms:
- `fd` finds files quickly
- `rg` searches text quickly

Fix:
- keep them installed at the OS level
- do not add them to lazy.nvim dependencies

### Problem 2: `UNL` scanner binary was missing

`checkhealth UnrealDev` reported:
- `UNL Scanner binary not found`

This scanner is the Rust piece that makes UNL’s file analysis work.

Without it, the library is installed but the actual analysis engine is missing.

Fix:
```bash
cd ~/.local/share/nvim/lazy/UNL.nvim
cargo build --release --manifest-path scanner/Cargo.toml
```

### Problem 3: Tree-sitter reported the standard C++ parser

`checkhealth UnrealDev` warned that the standard C++ parser was loaded instead of the Unreal-patched one.

Why that mattered:
- the standard parser does not understand Unreal’s special macros as well
- some Unreal-aware features depend on the custom grammar

So this was not cosmetic. It affected the features I wanted to use.

Fix:
- removed `cpp` from the default `ensure_installed` list
- overrode `nvim-treesitter.parsers.cpp` to use:
  - `https://github.com/taku25/tree-sitter-unreal-cpp`
  - revision `e2b94d3bd3ce359ff732116cc21f34ecbecfca50`

### Problem 4: `nvim-treesitter` got dirty local query files

Lazy.nvim complained about modified files under the plugin’s `runtime/queries/cpp/` directory.

Why it happened:
- I edited the installed plugin files directly while testing the parser swap
- lazy.nvim sees that as a local change and blocks clean updates

That was my mistake: I fixed the symptom too early, in the wrong place.

Fix:
- restored the modified query files
- let the parser override happen through config instead of editing plugin files directly

### Problem 5: `tree-sitter-manager` was missing

`checkhealth UnrealDev` warned that parser manager support was absent.

This tool matters because it installs the parser sources and helps keep the parser setup organized.

It’s the bridge between the parser repo and Neovim.

Fix:
- added `tree-sitter-manager.nvim`
- configured it to install the Unreal parsers

## Final workflow

If I were starting from scratch now, this is the order I’d follow.

1. Install system tools:
   - `fd`
   - `rg`
   - `cargo`
   - `jq`
   - `fzf`
2. Build UNL scanner
3. Install Tree-sitter manager and Unreal parsers
4. Generate `.unlrc.json` with `ue-unlrc`
5. Run `:UEP refresh`

## What I actually learned

The real lesson is that editor setup gets much easier when the layers are clear:
- wrapper for the suite
- parser manager for syntax
- small helper scripts for project config

- UnrealDev is easier to manage when the wrapper owns the suite and the individual plugins stay as dependencies.
- The C++ parser override must happen in config, not by hacking installed plugin files.
- `checkhealth` is useful because it points to the exact missing piece instead of guessing.
- A small helper like `ue-unlrc` removes boring setup work and makes new Unreal projects easier to start.

## Useful commands

```bash
ue-unlrc /path/to/MyProject.uproject
ue-unlrc .
```

```vim
:TSUpdate
:TSInstall cpp
:checkhealth UnrealDev
:UEP refresh
```

## Reviewed links

These are the links I actually read while figuring this out.

### Neovim and plugin docs
- https://github.com/taku25/UnrealDev.nvim
- https://github.com/taku25/UNL.nvim
- https://github.com/taku25/UEP.nvim
- https://github.com/taku25/UBT.nvim
- https://github.com/taku25/UCM.nvim
- https://github.com/taku25/ULG.nvim
- https://github.com/taku25/UNX.nvim
- https://github.com/taku25/neo-tree-unl.nvim
- https://github.com/folke/lazy.nvim

### Tree-sitter docs
- https://github.com/romus204/tree-sitter-manager.nvim
- https://github.com/taku25/tree-sitter-unreal-cpp
- https://github.com/taku25/tree-sitter-unreal-shader
- https://github.com/taku25/tree-sitter-verse

## Result

The setup now supports Unreal project discovery, engine config generation, Unreal-specific parser support, and the full UnrealDev wrapper flow.

More importantly, it now feels maintainable.
