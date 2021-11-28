# install nix
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
        nixpkgs.direnv

# stow
stow git
stow zsh
stow tmux
stow nvim

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh 

# install neovim plugins
nvim --headless +PlugInstall +qall
