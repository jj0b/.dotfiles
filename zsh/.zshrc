# include homebrew in path
export PATH="/opt/homebrew/bin:$PATH"

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# starship
eval "$(starship init zsh)"

# custom aliases
alias ls='lsd -la'
alias vim='nvim'
alias cat='bat'
alias dot='cd ~/.dotfiles'
alias cs='vim ~/.dotfiles/cheatsheet.md'

