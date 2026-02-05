-- login with `:Copilot auth`

-- Disable by default
vim.g.copilot_enabled = false

-- Toggle
vim.keymap.set("n", "<leader>c<Up>", ":Copilot enable<CR>")
vim.keymap.set("n", "<leader>c<Down>", ":Copilot disable<CR>")

-- disable copilot for dotfiles
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local path = vim.fn.expand("%:p")

    if path:match("/%.") then
      vim.b.copilot_enabled = false
    end
  end,
})

