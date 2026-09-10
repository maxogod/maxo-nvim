-- Fuzzy finding. Both pickers open their result in a new tab.
local function find_files()
    require("telescope.builtin").find_files({
        attach_mappings = function(_, map)
            local actions = require("telescope.actions")
            local state = require("telescope.actions.state")

            map({ "i", "n" }, "<CR>", function(prompt_bufnr)
                local entry = state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd.tabnew(entry[1])
            end)

            map({ "i", "n" }, "<C-s>", function(prompt_bufnr)
                local entry = state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd.vsplit(entry[1])
            end)

            return true
        end,
    })
end

local function live_grep()
    require("telescope.builtin").live_grep({
        attach_mappings = function()
            local actions = require("telescope.actions")
            actions.select_default:replace(function(prompt_bufnr)
                actions.select_tab(prompt_bufnr)
            end)
            return true
        end,
    })
end

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        keys = {
            { "<C-p>", find_files, desc = "Find files (opens in a new tab)" },
            { "<leader>fg", live_grep, desc = "Live grep (opens in a new tab)" },
            { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help tags" },
            { "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
        },
        opts = {
            defaults = {
                file_ignore_patterns = { "node_modules", "%.git/", "__pycache__" },
                layout_config = {
                    horizontal = { preview_width = 0.6 },
                },
            },
        },
    },
}
