if status is-interactive
    # Commands to run in interactive sessions can go here
    alias dcu 'docker-compose up'
    alias dcd 'docker-compose down'
end

set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_untracked yes
set -g theme_display_git_dirty yes
set -g theme_display_nvm yes
set -g theme_display_virtualenv yes
set -g theme_color_scheme nord

set -U fish_user_paths $fish_user_paths "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/"

set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim

# Homebrew installs conda in different locations depending on the type of Mac
# On M1 ARM it installs to /opt/homebrew/
# On Intel x86 it installs to /usr/local/
# To make this file work on both machines we need to use the following to get the correct path to conda:
# eval (string join '' (string split -r -m1 /bin/brew (which brew)) /Caskroom/miniconda/base/bin/conda) "shell.fish" "hook" $argv | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# eval (string join '' (string split -r -m1 /bin/brew (which brew)) /Caskroom/miniconda/base/bin/conda) "shell.fish" "hook" $argv | source
# <<< conda initialize <<<