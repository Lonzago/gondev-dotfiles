# =========================================================
# Keybindings - Custom key bindings
# =========================================================

# zsh-vi-mode configuration
# These must be set before zsh-vi-mode is loaded or in the zvm_after_init hook

# Cursor shape per vi mode (if zsh-vi-mode supports it)
# ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
# ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Disable command mode line highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

# Custom bindings that run after zsh-vi-mode initialization
zvm_after_init() {
  # Ctrl+Right -> move forward one word
  bindkey '^[[1;5C' forward-word

  # Ctrl+Left -> move backward one word
  bindkey '^[[1;5D' backward-word

  # Ctrl+F -> fzf file picker (no hidden files)
  bindkey '^F' _fzf_file_no_hidden

  # Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
  bindkey '^\' autosuggest-toggle

  # Up/Down -> history search by substring
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}