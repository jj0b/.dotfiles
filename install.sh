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
  brew install fish
  brew install deno
  brew install git
  brew install neovim
  brew install tmux
  brew install stow
  brew install yarn
  brew install fzf
  brew install ripgrep
  brew install bat
  brew install coreutils
  brew install lsd
  brew install derailed/k9s/k9s
  brew install kubectx
  brew install --cask miniconda

  echo "Installing Homebrew Cask..."
  brew install homebrew/cask 

  echo "Installing Homebrew Cask apps..."
  brew install --cask kitty
  brew tap microsoft/git
  brew install --cask git-credential-manager-core
  brew install go-task/tap/go-task
  brew install surrealdb/tap/surreal
  brew install --cask qlmarkdown
  
else
  curl -L https://nixos.org/nix/install | sh
  
  # source nix 
  . ~/.nix-profile/etc/profile.d/nix.sh
  
  # install packages
    nix-env -iA \
    nixpkgs.fish \
    nixpkgs.deno \
    nixpkgs.git \
    nixpkgs.neovim \
    nixpkgs.tmux \
    nixpkgs.stow \
    nixpkgs.yarn \
    nixpkgs.fzf \
    nixpkgs.ripgrep \
    nixpkgs.bat \
    nixpkgs.kitty \
    nixpkgs.go-task \
    nixpkgs.lsd \
    nixpkgs.k9s \
    nixpkgs.kubectx \

fi


# stow
stow git
stow fish
stow tmux
stow nvim
stow kitty
stow lsd

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
fisher install jorgebucaran/nvm.fish
fisher install acomagu/fish-async-prompt

echo "Use nvm to install node LTS"
nvm install lts

echo "Setting up NvChad submodule"
git submodule init
git submodule update

echo "Symlink NvChad customization"
ln -s ~/.dotfiles/nvchad/custom ~/.config/nvim/lua/custom

echo "Installing typescript-language-server, eslint_d and prettierd, emmet-ls"
npm install -g typescript-language-server eslint_d @fsouza/prettierd emmet-ls vscode-langservers-extracted

echo "Install neovim plugins"
$ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Configure miniconda for fish"
conda init fish
source ~/.config/fish/config.fish
conda config --set auto_activate_base False
conda config --set changeps1 False
source ~/.config/fish/config.fish
