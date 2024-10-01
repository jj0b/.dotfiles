# Commands for all sessions (both interactive and non-interactive)

# Check the architecture and set the Homebrew path accordingly
if test (uname -m) = "arm64"
    set -gx PATH /opt/homebrew/bin $PATH
else if test (uname -m) = "x86_64"
    set -gx PATH /usr/local/bin $PATH
end

# Add Go binaries to the PATH
set -gx PATH $PATH ~/go/bin

# Add DVM binaries to the PATH
set -gx PATH $PATH ~/.dvm/bin

# fast node manager
fnm env | source

# Universal environment variables
set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim

# Commands only for interactive sessions
if status is-interactive
    # Aliases for interactive use
    alias ls 'lsd -la'
    alias vim 'nvim'
    alias cat 'bat'
    alias dot 'cd ~/.dotfiles'
    alias cs 'vim ~/.dotfiles/cheatsheet.md'
end

# bobthefish theme customization
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_untracked yes
set -g theme_display_git_dirty yes
set -g theme_display_virtualenv yes
set -g theme_color_scheme nord

