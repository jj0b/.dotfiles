# install packages
if [[ $OSTYPE == 'darwin'* ]]; then

  # Check for Homebrew, install if needed
  if test ! $(which brew); then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi 

  echo "Turning off Homebrew analytics..."
  brew analytics off

  echo "Updating Homebrew..."
  brew update  

  echo "Installing Homebrew Formulae..."
  brew install zsh
  brew install deno
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
  brew install nvm
  brew install lsd
  brew install derailed/k9s/k9s
  brew install kubectx

  echo "Installing Homebrew Cask..."
  brew install homebrew/cask 

  echo "Installing Homebrew Cask apps..."
  brew install --cask kitty
  brew tap microsoft/git
  brew install --cask git-credential-manager-core
  brew install go-task/tap/go-task
  
else
  curl -L https://nixos.org/nix/install | sh
  
  # source nix 
  . ~/.nix-profile/etc/profile.d/nix.sh
  
  # install packages
    nix-env -iA \
    nixpkgs.zsh \
    nixpkgs.deno \
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
    nixpkgs.nvm \
    nixpkgs.go-task \
    nixpkgs.lsd \
    nixpkgs.k9s \
    nixpkgs.kubectx \

fi


# stow
stow git
stow zsh
stow tmux
stow nvim
stow kitty
stow lsd

echo "Use nvm to install node LTS"
nvm install --lts

echo "Installing typescript-language-server, eslint_d and prettierd"
npm install -g typescript-language-typescript eslint_d @fsouza/prettierd

echo "Add zsh to valid login shells..."
command -v zsh | sudo tee -a /etc/shells

echo "Use zsh as default shell..."
sudo chsh -s $(which zsh) $USER

echo "Bundle zsh plugins..."
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh 

echo "Install neovim plugins"
$ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
