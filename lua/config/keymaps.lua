-- Global keymaps. Buffer-local LSP maps live in lua/plugins/lsp.lua,
-- plugin-local maps live in that plugin's spec (`keys = { ... }`).
local map = vim.keymap.set
local toggles = require("config.toggles")

-- Help ------------------------------------------------------------------
map("n", "<leader>h", function()
    require("util.help").toggle()
end, { desc = "Toggle the cheat sheet" })

-- Movement --------------------------------------------------------------
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

map("n", "n", "nzzzv", { desc = "Next match, centred" })
map("n", "N", "Nzzzv", { desc = "Previous match, centred" })
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "Q", "<nop>")

-- Clipboard -------------------------------------------------------------
map("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("v", "<leader>x", [["+x]], { desc = "Cut to system clipboard" })
map("n", "<C-a>", "ggVG", { desc = "Select the whole buffer" })

-- Undo / redo / save ----------------------------------------------------
map("n", "<C-z>", "<Cmd>undo<CR>", { desc = "Undo" })
map("n", "<C-y>", "<Cmd>redo<CR>", { desc = "Redo" })
map("n", "<C-s>", "<Cmd>write<CR>", { desc = "Save buffer" })
map("n", "<C-A-s>", "<Cmd>wall<CR>", { desc = "Save every buffer" })

-- Tabs ------------------------------------------------------------------
map("n", "<leader>t", "<Cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<A-Right>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<A-Left>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<A-w>", "<Cmd>quit<CR>", { desc = "Close window" })
for i = 1, 9 do
    map("n", "<leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>", { desc = "Go to tab " .. i })
end

-- Editing ---------------------------------------------------------------
map("n", "<C-S-Up>", "yyp", { desc = "Duplicate line" })
map("n", "<C-S-Down>", "yyp", { desc = "Duplicate line" })
map("v", "<C-S-Up>", ":t'>p<CR>", { desc = "Duplicate selection" })
map("v", "<C-S-Down>", ":t'>p<CR>", { desc = "Duplicate selection" })

map("i", "<C-BS>", "<C-w>", { desc = "Delete word before cursor" })
map("i", "<C-Del>", "<C-o>dw", { desc = "Delete word after cursor" })
map("n", "<S-d>", "dd", { desc = "Delete line" })
map("n", "<CR><CR>", "o<Esc>", { desc = "Append an empty line" })

map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Folding ---------------------------------------------------------------
map("n", "c1", "zc", { desc = "Collapse current fold" })
map("n", "c2", "zMzv", { desc = "Collapse all but the current fold" })
map("n", "c3", "zM", { desc = "Collapse everything" })
map("n", "x0", "zo", { desc = "Expand current fold" })
map("n", "x1", "zO", { desc = "Expand current fold and its children" })
map("n", "x2", "zr", { desc = "Expand one level" })
map("n", "x3", "zR", { desc = "Expand everything" })
map("n", "<C-A-k>", "zM", { desc = "Collapse everything" })
map("n", "<C-A-l>", "zR", { desc = "Expand everything" })
map("n", "<C-k>", "zc", { desc = "Collapse current fold" })
map("n", "<C-l>", "zo", { desc = "Expand current fold" })

-- Toggles ---------------------------------------------------------------
map("n", "<leader>tf", toggles.format_on_save, { desc = "Toggle format on save" })
map("n", "<leader>bg", toggles.transparency, { desc = "Toggle background transparency" })
map("n", "<leader>wr", toggles.wrap, { desc = "Toggle line wrap" })

-- Config ----------------------------------------------------------------
map("n", "<leader><leader>", "<Cmd>source %<CR>", { desc = "Source the current file" })

-- Quit everything at once.
vim.api.nvim_create_user_command("Shutdown", function()
    vim.cmd("tabnew")
    vim.cmd("tabonly")
    vim.cmd("quit!")
end, { desc = "Close every tab and quit" })
