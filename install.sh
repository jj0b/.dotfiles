# install packages
if [[ $OSTYPE == 'darwin'* ]]; then

  # Check for Homebrew, install if needed
  if test ! $(which brew); then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi 

  echo "Updating Homebrew..."
  brew update  

  echo "Installing Homebrew Formulae..."
  brew install zsh
  brew install antibody
  brew install git
  brew install neovim
  brew install tmux
  brew install stow
  brew install yarn
  brew install fzf
  brew install ripgrep
  brew install bat
  brew install coreutils
  brew install redis
  brew install postgresql

  echo "Installing Homebrew Cask..."
  brew install caskroom/cask/brew-cask

  echo "Installing Homebrew Cask apps..."
  brew install --cask kitty
  brew tap microsoft/git
  brew install --cask git-credential-manager-core
  
else
  curl -L https://nixos.org/nix/install | sh
  
  # source nix 
  . ~/.nix-profile/etc/profile.d/nix.sh
  
  # install packages
    nix-env -iA \
    nixpkgs.zsh \
    nixpkgs.antibody \
    nixpkgs.git \
    nixpkgs.neovim \
    nixpkgs.tmux \
    nixpkgs.stow \
    nixpkgs.yarn \
    nixpkgs.fzf \
    nixpkgs.ripgrep \
    nixpkgs.bat \
    nixpkgs.kitty \

fi

# stow
stow git
stow zsh
stow tmux
stow nvim
stow kitty

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh 

# install neovim plugins
nvim --headless +PlugInstall +qall

