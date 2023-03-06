#!/bin/sh

cd ~
## Update the system
sudo pacman -Syu

## Install xorg, i3 and dmenu

sudo pacman -S xorg-server xorg-xinit i3-wm dmenu

## Install git and neovim
sudo pacman -S install git neovim nitrogen dunst flameshot xorg-xrandr

## Install paru
sudo pacman -S --needed base-devel
git cloen https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~ 
rm -rf paru

# install starship prompt
curl -sS https://starship.rs/install.sh | sh

# setup the config
git clone https://github.com/EvgeniGenchev/dotfiles
cd dotfiles
cp -r my_utils ~/my_utils
cp -r .config ~/.config
cp .bashrc ~/.bashrc
cp .xintirc ~/.xinitrc

# install alacritty
cd ~
git clone https://aur.archlinux.org/alacritty-git.git
cd alacritty-git/
makepkg -si
