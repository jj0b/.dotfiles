# stow
echo "Stowing directories..."
# ~/.cursor must be a real directory so stow links only ~/.cursor/skills
mkdir -p ~/.cursor
stow cursor
stow ghostty
stow git
stow lsd
stow nvim
stow tmux
stow zsh