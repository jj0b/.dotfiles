# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Detect CPU architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
  # Apple Silicon (M1, M2, etc.)
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  # Intel Macs
  export HOMEBREW_PREFIX="/usr/local"
fi

# Initialize Homebrew if installed
if [[ -f "$HOMEBREW_PREFIX/bin/brew" ]]; then
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# Include Homebrew in the path
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

# Node Version Manager (NVM) Setup
if [ -n "$TMUX" ]; then
  if [ -f "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]; then
    source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # Load NVM
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion"  # Load NVM Bash Completion

# Include Deno Version Manager in the path
export DVM_DIR="/Users/jason/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# Include Go binaries to the path
export PATH="$PATH:$HOME/go/bin"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='lsd -la'
alias vim='nvim'
alias cat='bat'
alias dot='cd ~/.dotfiles'
alias cs='vim ~/.dotfiles/cheatsheet.md'
alias tg='templ generate'
alias dcu 'docker compose up --build'
alias dcd 'docker compose down'
alias dr='darwin-rebuild switch --flake ~/.dotfiles/nix#zen'

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"

export BAT_THEME="Nord"

