# stow

echo "Stowing directories..."
stow git
stow tmux
stow ghostty
stow zsh
stow lsd

# Neovim

echo "Installing NVChad..."
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

echo "Remove default custom folder for NVChad..."
sudo rm -rf ~/.config/nvim/lua/custom/

echo "Symlink NvChad customization..."
ln -s ~/.dotfiles/nvchad/custom ~/.config/nvim/lua/custom

# VS Code

echo "Enable key repeat in VSCode to support Vim motions..."
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# macOS

echo "Configure screenshot preview display time..."
defaults write com.apple.screencaptureui "thumbnailExpiration" -float 15 && killall SystemUIServer
