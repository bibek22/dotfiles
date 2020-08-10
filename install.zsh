#!/usr/bin/zsh

cd $HOME

git clone "https://aur.archlinux.org/yay.git"
cd yay
yes | makepkg -Sri && yes | pacman -U yay*tar.gz
yes | pacman -S stow

cd $HOME

git clone "https://github.com/bibek22/dotfiles"
cd dotfiles
[ -a "$HOME/build" ] && mv "$HOME/build" "$HOME/build.old" 
stow build
stow dots
[ -a "$HOME/.config" ] && mv "$HOME/build" "$HOME/.config.old" 
stow config
[ -a "$HOME/.local" ] && mv "$HOME/build" "$HOME/.local.old" 
stow bins

cd build/dwm && make
cd build/st && sudo make install 
