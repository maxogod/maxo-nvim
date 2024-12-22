-- leader
vim.g.mapleader = " "

-- Explore without nvim tree
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Toggle the file explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Set a keybinding to focus back on NvimTree
vim.api.nvim_set_keymap('n', '<leader>b', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

-- Move line up and down
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- Scroll up and down
vim.keymap.set("n", "<C-S-Up>", "<C-u>zz")
vim.keymap.set("n", "<C-S-Down>", "<C-d>zz")

-- next and prev when searching patterns
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy into system clipboard
vim.keymap.set("v", "<leader>y", [["+y]])
-- Cut into system clipboard
vim.keymap.set("v", "<leader>x", [["+x]])

-- Undo - Redo
vim.keymap.set("n", "<C-z>", "<Cmd>u<CR>")
vim.keymap.set("n", "<C-y>", "<Cmd>redo<CR>")

-- Disable (shift - q)
vim.keymap.set("n", "Q", "<nop>")

-- format current buffer (if lsp is available)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
