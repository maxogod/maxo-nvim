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
vim.keymap.set('n', '<C-p>', function()
    builtin.find_files({
        attach_mappings = function(_, map)
            local action_state = require("telescope.actions.state")
            local actions = require("telescope.actions")

            -- Open in new tab with Enter
            map("i", "<CR>", function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("tabnew " .. entry[1])
            end)

            -- Open in a vertical split with Shift+Enter
            map("i", "<C-v>", function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("vsplit " .. entry[1])
            end)
            return true
        end
    })
end, { desc = 'Telescope find files (new tab / vsplit)' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
