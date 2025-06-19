-- leader
vim.g.mapleader = " "

-- Help
vim.keymap.set("n", "<leader>h", function()
    local config_path = vim.fn.stdpath("config") .. "/help.md"
    vim.cmd("!" .. "cat " .. config_path)
end, { noremap = true, silent = true })

-- Explore without nvim tree
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Toggle the file explorer (nvim tree)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Move line up and down
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")

-- -- Scroll up and down
-- vim.keymap.set("n", "<C-S-Up>", "<C-u>zz")
-- vim.keymap.set("n", "<C-S-Down>", "<C-d>zz")

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

-- Move between tabs
vim.keymap.set("n", "<A-Right>", ":tabnext<CR>")
vim.keymap.set("n", "<A-Left>", ":tabprevious<CR>")

-- Move to specific tab
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, ":tabnext " .. i .. "<CR>")
end

-- Duplicate the current line
vim.keymap.set("n", "<C-S-Up>", "yyp")
vim.keymap.set("n", "<C-S-Down>", "yyp")
vim.keymap.set("v", "<C-S-Up>", ":t'>p<CR>")
vim.keymap.set("v", "<C-S-Down>", ":t'>p<CR>")

-- Multicursor
vim.keymap.set('n', '<A-S-Up>', '<Plug>(VM-Add-Cursor-Up)', { desc = "Add cursor up" })
vim.keymap.set('n', '<A-S-Down>', '<Plug>(VM-Add-Cursor-Down)', { desc = "Add cursor down" })

-- Commenting
vim.api.nvim_set_keymap('v', '<leader>/', ':Commentary<CR>', { noremap = true, silent = true })

-- create tab
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')

-- Remove entire word
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Del>', '<C-o>dw', { noremap = true, silent = true })

-- Remove current line
vim.api.nvim_set_keymap('n', '<S-d>', 'dd', { noremap = true, silent = true })

-- Add \n
vim.keymap.set("n", "<CR><CR>", "o<Esc>", { noremap = true, silent = true })

-- Indent/Unindent with Tab
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- Refactor
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Save changes
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<C-A-s>", ":wa<CR>")

-- Format on Save
vim.api.nvim_set_keymap("n", "<leader>tf", ":lua ToggleFormatOnSave()<CR>", { noremap = true, silent = true })

-- Nvim command to close everything
vim.api.nvim_create_user_command('Shutdown', function()
    vim.cmd('tabnew')
    vim.cmd('tabonly')
    vim.cmd('q!')
end, {})

-- Folding
vim.api.nvim_set_keymap('n', '<C-A-k>', 'zM', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-l>', 'zR', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', 'zc', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', 'zo', { noremap = true, silent = true })

-- Refresh LSP
vim.api.nvim_set_keymap('n', '<leader>lr', ':LspRestart<CR>', { noremap = true, silent = true })

-- Find & Replace
vim.keymap.set('n', '<leader>fr', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
