# MaxoNvim - Config

My config for my nvim text editor! B)

![maxonvim home](https://github.com/user-attachments/assets/ea35fe87-87d6-44d7-a0cf-ad242b95ff23)

## Setup

* Install neovim **>= 0.11** (0.12 recommended)
* Clone this repo into `~/.config/nvim` (linux) or `~\AppData\Local\nvim` (windows)
* Start `nvim`. [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself,
  installs and preps everything on first launch.
* `:Mason` installs the language servers; the ones listed in `lua/lsp/` are
  installed automatically the first time you open Neovim with a UI.
* Add `./font/HackNerd.ttf` to `~/.local/share/fonts` (on windows just open and
  install it) and select it in your terminal so the nvim-tree icons render.
* `:checkhealth` for troubleshooting.

### Required system packages

* tree-sitter-cli - builds the parsers [`npm install -g tree-sitter-cli`]
* a C compiler (`gcc` / `cc`) - also for the parsers
* ripgrep - telescope live grep [`sudo apt install -y ripgrep`]
* xclip, or another clipboard provider [`sudo apt install -y xclip`]
* a JRE - only for the `ltex` grammar server [`sudo apt install -y default-jre`]
* the dotnet SDK - only for the `omnisharp` C#

## Optional

Create an alias:

```bash
echo alias vim='nvim' >> ~/.bashrc # for linux (in windows create a sys-env-var)
source ~/.bashrc
```

## Layout

```bash
init.lua                 # entrypoint, requires config/* in order
lua/config/
  options.lua            # vim.opt settings, leader, feature flags
  keymaps.lua            # global keymaps
  autocmds.lua           # global autocommands
  diagnostics.lua        # vim.diagnostic presentation
  toggles.lua            # runtime toggles (format on save, transparency, wrap)
  greeter.lua            # start screen banner
  compat.lua             # shims for upstream breakage, delete when unneeded
  lazy.lua               # lazy.nvim bootstrap + setup
lua/plugins/*.lua        # one lazy.nvim spec per concern
lua/lsp/<server>.lua     # per language-server config
lua/util/*.lua           # helpers shared between specs
```

### Adding a plugin

Create a file under `lua/plugins/` returning a lazy.nvim spec. Nothing else
needs to change — `lua/config/lazy.lua` imports the whole directory.

```lua
-- lua/plugins/example.lua
return {
    {
        "owner/repo",
        event = "SomeEvent",
        opts = {},
    },
}
```

### Adding a language server

Create `lua/lsp/<lspconfig-server-name>.lua` returning a config table. It is
merged on top of the defaults nvim-lspconfig ships, added to Mason's
`ensure_installed` list, and enabled.

```lua
-- lua/lsp/pyright.lua
return {
    settings = { python = { analysis = { typeCheckingMode = "basic" } } },
}
```

Add `install = false` for servers Mason cannot install — see
`lua/lsp/gdscript.lua`, which connects to a running Godot editor instead.

## Commands

* `:Lazy` — plugin manager (`<leader>L`)
* `:Mason` — language server catalog (`<leader>m`)
* `:checkhealth` — diagnose the setup
