# .dotfiles

## Prerequisites

### Nerd Fonts Symbols Only

- Download and install NerdFontsSymbolsOnly.zip from [https://github.com/ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts).

### Git

- Git must be installed to clone this repo.
- If on macOS a version of git is included by default.
- If on Linux you may have to install git.
- On Ubuntu you can do this with:

```bash
sudo apt update
sudo apt upgrade
sudo apt install git
```

## Installation

- Clone this repository and run the install script:

```bash
git clone git@github.com:jj0b/.dotfiles.git
cd .dotfiles
./install.sh
```

- After the script is finished open init.vim:

```bash
vim ~/.config/nvim/init.vim
```

- In vim (actuall `neovim` as `vim` is aliased to it) install plugins:

```vim
so %
PlugInstall
```

## Usage

For custom key commands for `vim` and `tmux` you can checkout the `cheatsheet.md` which is aliased to `cs`.
