# stow
echo "Stowing directories..."
stow ghostty
stow git
stow lsd
stow nvim
stow tmux
stow zsh

# node is required to install some Mason LSPs in nvim
nvm install --lts