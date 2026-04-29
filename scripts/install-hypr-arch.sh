#! bin/bash


echo -e "\n\t=== === === === === === === === === === ==="
echo -e "\t===   DotFiles Gondev 0.01 Arch Linux   ==="
echo -e "\t=== === === === === === === === === === ===\n\n"



echo -e "\n\t Installing dependencies"

sudo pacman -Syu

# Install basics
sudo pacman -S hyprland rofi waybar fastfetch gcc git curl thunar eza dosfstools ntfsprogs nwg-look

#Install Terminal Stuffs
sudo pacman -S neovim kitty zsh ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick yazi

#Install Browser
sudo pacman -S firefox

# Install yay 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 




# Install AUR packages
yay -S swww waypaper
# Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\n\tCambiando la shell basica por zsh"
chsh -s $(which zsh)