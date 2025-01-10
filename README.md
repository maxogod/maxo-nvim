# mynvimconfig
just some config

<div align="center">
  <img src="https://i.pinimg.com/originals/86/70/c4/8670c4da3a580725b13a12ac86808bce.png" width="220px" height="300" alt="Pokemon trainer using PC">
</div>

## Setup

* Clone this repo into /.config/nvim (different for windows)
* Install neovim **>= 0.10.0** (i had to use *snap*)
* Clone packer (https://github.com/wbthomason/packer.nvim)
* :so packer.lua and :PackerSync
* :Mason for lsps and linters
* :checkhealth for troubleshooting
* add font in font/ to ~/.local/share/fonts and set it for the terminal to be able to see sidebar icons

Add alias for nvim:
```bash
nvim ~/.bashrc
# type `alias vim='nvim'` at the end of the file
source ~/.bashrc
```

## Additional setup 

Also install tree-sitter-cli locally
and ripgrep

TODO:
add a help file to be displayed on leader + h
