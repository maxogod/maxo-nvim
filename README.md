# MaxoNvim

My config for my nvim text editor! B)

![maxonvim home](https://github.com/user-attachments/assets/ea35fe87-87d6-44d7-a0cf-ad242b95ff23)

## Setup

* Clone this repo into `~/.config/nvim` (linux) or `~\AppData\Local\nvim` (windows)
* Install neovim **>= 0.10.0**
* Clone [packer](https://github.com/wbthomason/packer.nvim)
* :so packer.lua and :PackerSync
* :Mason for LSPs
* add `./font/HackNerd.ttf` to `~/.local/share/fonts` (for windows just open and install it) and set it for the terminal to be able to see nvim-tree icons
* :checkhealth for troubleshooting

## Optional

Create an alias:

```bash
echo alias vim='nvim' >> ~/.bashrc # for linux (in windows create a sys-env-var)
source ~/.bashrc
```

### Full functionality

You will need to install the following packages for all the features to work properly:

* tree-sitter-cli
* ripgrep

