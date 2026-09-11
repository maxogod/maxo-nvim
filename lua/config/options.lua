-- Editor options. Loaded first, before lazy.nvim.

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- line numbers
opt.number = true

-- indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- wrapping
opt.wrap = false

-- search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- colors
opt.termguicolors = true

-- time after which the CursorHold autocommand is triggered
opt.updatetime = 50

-- folding (treesitter takes over per-buffer where a parser exists)
opt.foldmethod = "indent"
opt.foldlevel = 99

-- no swap files
opt.swapfile = false

-- completion menu behaviour (blink.cmp respects this)
opt.completeopt = { "menu", "menuone", "noselect" }

-- Feature flags read by lua/config/toggles.lua
vim.g.format_on_save = true
vim.g.transparent_background = true

-- Diff format
vim.opt.diffopt:append("vertical")

-- Activate sign column used for git diff indicator
vim.opt.signcolumn = "yes"

-- highlight on text search
vim.opt.hlsearch = true
vim.opt.incsearch = true
