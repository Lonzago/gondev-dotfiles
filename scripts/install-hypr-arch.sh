#! bin/bash

## run curl -fsSL https://github.com/Lonzago/gondev-dotfiles/blob/main/scripts/install-hypr-arch.sh | bash

echo -e "\n\t=== === === === === === === === === === ==="
echo -e "\t===   DotFiles Gondev 0.01 Arch Linux   ==="
echo -e "\t=== === === === === === === === === === ===\n\n"



echo -e "\n\t Installing dependencies"

sudo pacman -Syu

# Install basics
sudo pacman -S hyprland rofi waybar fastfetch gcc git curl thunar eza dosfstools ntfsprogs nwg-look

#Install Terminal Stuffs
sudo pacman -S neovim kitty zsh ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick yazi bat

#Install Browser
sudo pacman -S firefox

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si



# Install AUR packages
yay -S swww waypaper

# Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "\n\t Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --skip-chsh
fi

# Install Oh My Zsh external plugins
echo -e "\n\t Installing Oh My Zsh plugins"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom/plugins"

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting"
fi

# zsh-vi-mode (enhanced vi mode for zsh)
if [ ! -d "$ZSH_CUSTOM/zsh-vi-mode" ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH_CUSTOM/zsh-vi-mode"
fi

echo -e "\n\t === Installation complete! ==="
echo -e "\n\t Next steps:"
echo -e "\t 1. Restart your terminal or run: exec zsh"
echo -e "\t 2. Deploy your dotfiles: cd gondev-dotfiles && ./scripts/stow-deploy.sh"

