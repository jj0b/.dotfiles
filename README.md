# .dotfiles

Note that if you are not me and are wanting to use my dotfiles, that before installation you will want to edit your name and email address in `git/.gitconfig` to be your own. Also note that my `flake` has the name `zen` but you can update that in the `flake` to whatever you want, then make sure to use your new name when calling `darwin-rebuild`. (see below)

This repo contains my dotfiles for `zsh` (with `p10k`), `tmux`, `nvim`, `git`, and `ghostty`, as well as a `nix` `flake` to fully configure my macOS system for development. You can edit the flake to install the nixpks, homebrew formulae, casks, or taps that yuo want, as well as configure your macOS systems preferences.

Currently `nix` `flakes` aren't usable if they are symlinked so it is not possible to `stow` the `nix` folder. Instead the current setup flow is to install `nix`, copy the `nix` folder to your home directory, and run the `darwin-rebuild` command on it there.

Once `nix` has installed all the prerequisites and configured the system then the dotfiles are ready to be symlinked with `stow` which can be done for all of them by running the install script.

## Install nix

I recommend installing `nix `using [Determinate](https://github.com/DeterminateSystems/nix-installer) because it makes unintalling `nix `easy, something that is not true of other installation methods.

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

When answering the questions during `nix` installation choose to only install `nix`, not `Determinate`, which is not needed.

## Copy nix folder

```bash
cp -r ~/.dotfiles/nix ~/nix
```

## Use the flake

To bootstrip nix-darwin, the firt time you use your flake you do:

```bash
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/nix#zen
```

The result will be that nix-darwin is now installed so thereafter you can use:

```bash
darwin-rebuild switch --flake ~/nix#zen
```

## Install the dotfiles

With all the dependencies installed you can now install the dotfiles with:

```bash
cd ~/.dotfiles
./install.sh
```

## Neovim

I use the [NvChad](https://nvchad.com/docs/quickstart/install) starter for my `nvim` config. When you first open nvim `Lazy` should install all the plugins automatically but you need to manually run `MasonInstallAll `for all the `LSP` stuff.

## Uninstalling nix

If you ever need to uninstall `nix` it is crucial that you first uninstall `nix-darwin`, then `nix`.

```bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
```

```bash
/nix/nix-installer uninstall
```
