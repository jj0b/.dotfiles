In ~/.dotfiles run:

```bash
git submodule init
git submodule update
```

The `custom` directory here must be symlinked to `nvim/.config/lua/custom` as this folder contains all customization for `NvChad` which is a submodule in this `dotfiles` repo.

```bash
ln ~/.dotfiles/nvchad/custom ~/.dotfiles/nvim/.config/.nvim/lua/
```
