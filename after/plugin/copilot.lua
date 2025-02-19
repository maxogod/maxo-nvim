-- login with `:Copilot auth`

-- Disable by default
vim.g.copilot_enabled = false

-- Toggle
vim.keymap.set("n", "<leader>c<Up>", ":Copilot enable<CR>")
vim.keymap.set("n", "<leader>c<Down>", ":Copilot disable<CR>")

