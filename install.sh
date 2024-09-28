# Homebrew packages

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

echo "Installing Homebrew Cask..."
brew install homebrew/cask 

echo "Installing Homebrew Cask apps..."
brew install --cask kitty
brew tap microsoft/git
brew install --cask git-credential-manager-core
brew install qlmarkdown

# stow

stow git
stow fish
stow tmux
stow kitty
stow lsd
stow zsh

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

# OhMyZsh

echo "Installing OhMyZsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship prompt

brew install starship

# macOS

echo "Configure screenshot preview display time..."
defaults write com.apple.screencaptureui "thumbnailExpiration" -float 15 && killall SystemUIServer