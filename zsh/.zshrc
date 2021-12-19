# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Export nvm completion settings for lukechilds/zsh-nvm plugin
# Note: This must be exported before the plugin is bundled
export NVM_DIR=${HOME}/.nvm
export NVM_COMPLETION=true

# source plugins
source ~/.zsh_plugins.sh

# aliases

# use neovim
alias vim='nvim'

alias vimrc='vim ${HOME}/.config/nvim/init.vim'
alias cheat='vim ${HOME}/.dotfiles/cheatsheet.md'
alias cat='bat'

# hardhat 
alias nhc='npx hardhat compile'
alias nhn='npx hardhat node'
alias nhrl='npx hardhat run scripts/deploy.js --network localhost'

# macOS specific
if [[ "$OSTYPE" = darwin* ]]; then
    # use gls on macOS for dircolors
    alias ls='gls --color=always -G -al'

    alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
    # worlds
    alias worlds='cd ~/Code/dApp/worlds-project'
    # jupiter
    alias jupiter='cd ~/Code/hypergiant/jupiter/jupiter-web'
    alias ys='yarn workspace @jupiter/server' 

    # use nord-dircolors
    # for macOS need to install coreutils (can do with brew) 
    # then include this PATH and MANPATH
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    
    test -e ~/.dir_colors && eval `gdircolors -b ~/.dir_colors`
else
    # better ls
    alias ls='ls -al'

    # use node-dircolors
    test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)
fi

# use nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi 


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
