REPO="https://github.com/eendroroy/alacritty-theme.git"
DEST="$HOME/.config/alacritty/eendroroy-themes"
# Get colorschemes
git clone $REPO $DEST
# Create symlink at default colors location (optional)
ln -s "$DEST/themes" "$HOME/.config/alacritty/colors"
