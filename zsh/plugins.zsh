# =========================================================
# Plugin Manager - Auto-install plugins from GitHub
# =========================================================

ZPLUGINDIR="$HOME/.local/share/zsh/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  # Try different loading strategies
  if [[ -f "${plugin_path}/${2}.plugin.zsh" ]]; then
    source "${plugin_path}/${2}.plugin.zsh"
  elif [[ -f "${plugin_path}/${2}.zsh" ]]; then
    source "${plugin_path}/${2}.zsh"
  elif [[ -f "${plugin_path}/${2}.sh" ]]; then
    source "${plugin_path}/${2}.sh"
  elif [[ -f "${plugin_path}/init.zsh" ]]; then
    source "${plugin_path}/init.zsh"
  elif [[ -f "${plugin_path}/plugin.zsh" ]]; then
    source "${plugin_path}/plugin.zsh"
  fi
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only 2>/dev/null || echo "  (no updates)"
  done
}

# Load plugins (auto-installs if missing)
_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-syntax-highlighting
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load jeffreytse zsh-vi-mode
_zplugin_load zdharma-continuum fast-syntax-highlighting