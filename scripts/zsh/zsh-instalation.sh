#!bin/bash

DOTFILES_DIR="$HOME/gondev-dotfiles"

echo "=== Zsh Instalation Script ==="

echo "--> Install requiered packages"
sudo pacman -Sy --needed zsh stow starship zoxide fzf fd bat ripgrep eza yazi lazygit lazydocker
echo "✅  DONE"


echo "--> Install Oh-My-Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else 
  echo "Skiped oh-my-zsh, already exist"
fi
echo "✅  DONE"


echo "--> Install Oh-My-Zsh Plugins"
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins/"

[ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
[ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"

echo "✅  DONE"



echo "--> Stow Zsh config files"
echo "->Removing exiting files to stow"
[ -f "$HOME/.zshrc" ] && rm "$HOME/.zshrc"
[ -f "$HOME/.config/starship.toml" ] && rm "$HOME/.config/starship.toml"

cd "$DOTFILES_DIR" && stow zsh 
echo "✅  DONE"


echo "--> Change default shell to zsh"
if [ ! "$0" == "zsh"  ]; then
  chsh -s "$(which zsh)"
  echo "-> Changed shell"
fi
echo "✅  DONE"
