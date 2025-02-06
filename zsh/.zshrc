# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# include homebrew in path
export PATH="/opt/homebrew/bin:$PATH"

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# custom aliases
alias ls='lsd -la'
alias vim='nvim'
alias cat='bat'
alias dot='cd ~/.dotfiles'
alias cs='vim ~/.dotfiles/cheatsheet.md'

# set DVM path
export DVM_DIR="/Users/jason/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# add Go binaries to the PATH
export PATH="$PATH:$HOME/go/bin"
