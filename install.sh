Check for Homebrew, install if needed
if test ! $(which brew); then
  echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Turning off Homebrew analytics..."
brew analytics off
echo "Updating Homebrew..."
brew update  

echo "Installing Homebrew Formulae..."
brew install neovim
brew install tmux
brew install stow
brew install fzf
brew install ripgrep
brew install bat
brew install coreutils
brew install lsd
brew install qlmarkdown
brew install fish

brew install homebrew/cask 
brew install --cask kitty
brew tap microsoft/git
brew install --cask git-credential-manager-core

# stow

echo "Stowing directories..."
stow git
stow tmux
stow kitty
stow lsd
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.backup
stow fish

# fish

echo "Add fish to valid login shells..."
command -v fish | sudo tee -a /etc/shells

echo "Use fish as default shell..."
sudo chsh -s $(which fish) $USER

echo "Install fisher plugin manager for fish shell"
exec fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install oh-my-fish/plugin-brew
fisher install oh-my-fish/theme-bobthefish
fisher install oh-my-fish/plugin-extract

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
