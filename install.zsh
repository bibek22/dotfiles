#!/usr/bin/zsh
#This wont run cleanly. This is mostly only for reference as of now.
#Initialize env variables
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
export XDG_DATA_HOME="$HOME/.config/"

function startsession() {
    echo "########################################################"
    echo "##    $1"
    echo "########################################################"
    [ -n $2 ] && echo "$2" || echo "Any key to continue "
    read confirmation
}

function prepare() {
    cd $HOME
    which yay || ( git clone "https://aur.archlinux.org/yay.git" && cd yay \
    && yes | makepkg -Sri && makepkg -s --install )
    # check if stow exists
    which stow || yes | sudo pacman -S stow
}

function dotfiles(){
    cd $HOME
    [ -d dotfiles ] || git clone --recurse-submodules "https://github.com/bibek22/dotfiles"
    cd dotfiles
    startsession "stowing build dir"
    [ -d "$HOME/build" ] && mv "$HOME/build" "$HOME/build.old" 
    stow build
    startsession "stowing dots dir"
    stow dots
    [ -d "$HOME/.config" ] && mv "$HOME/.config" "$HOME/.config.old" 
    stow config
    [ -d "$HOME/.local" ] && mv "$HOME/.local" "$HOME/.local.old" 
    stow bins
}
function setupnvim () {
    # First install vim-plug
    [ -f "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim ] || sh -c \
    'curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs \
               https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    # install plugins
    
    nvim -c ":PluginInstall"
}

function setupzsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone "https://github.com/zdharma/fast-syntax-highlighting.git" \
          "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
    git clone  "https://github.com/zsh-users/zsh-autosuggestions" \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
}

function buildthings() {
     echo "building dwm"
     cd $HOME
     cd build/dwm
     make 
     echo "building st"
     cd ../st
     sudo make install
}

function installfonts() {
    local location, target
    location="$HOME/dotfiles/fonts/"
    target="$HOME/.local/share/fonts"
    unzip $location/Sh*.zip
    (  [ -d "$target" ] || mkdir $target ) && mv $location/*.ttf $target
}

# startsession "Installing stow and yay-AUR helper"
# prepare
# startsession "Cloning dotfiles"
# dotfiles || exit
# buildthings
setupzsh
