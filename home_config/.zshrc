## INITIALIZATION 

##Init starship
if [[ $- == *i* ]] && [[ ${TERM:-} != "dumb" ]] && command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

if command -v try &> /dev/null; then
  try() {
    unset -f try
    eval "$(SHELL=/bin/bash command try init ~/Work/tries)"
    try "$@"
  }
fi

export ZSH="$HOME/.oh-my-zsh"

## PLUGINS
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)


## Vim editing for editor
set -o vi

export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"

CASE_SENSITIVE=false

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"


# For a full list of active aliases, run `alias`.
  if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
else
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi
alias eff='$EDITOR "$(ff)"'
sff() { if [ $# -eq 0 ]; then echo "Usage: sff <destination> (e.g. sff host:/tmp/)"; return 1; fi; local file; file=$(find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2- | ff) && [ -n "$file" ] && scp "$file" "$1"; }

if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if (( $# == 0 )); then
      builtin cd ~ || return
    elif [[ -d $1 ]]; then
      builtin cd "$1" || return
    else
      if ! z "$@"; then
        echo "Error: Directory not found"
        return 1
      fi

      printf "\U000F17A9 "
      pwd
    fi
  }
fi

# Yazi finder. Note 'q' is to go cmd
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


open() (
  xdg-open "$@" >/dev/null 2>&1 &
)

alias zshconf="nvim ~/.zshrc"
alias py="python"

alias lg="lazygit"
alias ld="lazydocker"


alias ts="sudo timeshift"
alias tsc="sudo timeshift --create"

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias root='cd /'

# Tools
alias v='nvim'


alias oc='opencode'
alias cx='printf "\033[2J\033[3J\033[H" && claude --permission-mode bypassPermissions'
alias d='docker'
alias r='rails'
alias t='tmux attach || tmux new -s Work'
alias i='tdl c cx'
n() { if [ "$#" -eq 0 ]; then command nvim . ; else command nvim "$@"; fi; }


# Git
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# Example aliases
alias cl="clear"

source ~/.oh-my-zsh/oh-my-zsh.sh

# File system
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi



