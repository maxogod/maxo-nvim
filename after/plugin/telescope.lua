-- Telescope setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git" },
    layout_config = {
      horizontal = { preview_width = 0.6 },
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

