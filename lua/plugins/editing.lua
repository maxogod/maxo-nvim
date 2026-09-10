return {
    -- Wrap a selection in brackets/quotes: `S"` in visual mode, `ys`/`cs`/`ds`
    -- in normal mode.
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {
            -- no padding spaces: [a] rather than [ a ]
            surrounds = {
                ["["] = { add = { "[", "]" } },
                ["("] = { add = { "(", ")" } },
                ["{"] = { add = { "{", "}" } },
            },
        },
    },

    -- Self-closing brackets and quotes, tree-sitter aware.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                check_ts = true,
                fast_wrap = {},
            })

            -- Block comments: typing `/*` closes it with `*/`.
            local Rule = require("nvim-autopairs.rule")
            autopairs.add_rule(Rule("/*", "*/", { "c", "cpp", "cs", "css", "scss", "java", "javascript", "typescript" }))
        end,
    },

    -- Multiple cursors: <A-S-Up>/<A-S-Down> to stack them, <C-n> to grab the
    -- next occurrence of the word under the cursor.
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
        init = function()
            vim.g.VM_maps = { ["Add Cursor Up"] = "<A-S-Up>", ["Add Cursor Down"] = "<A-S-Down>" }
        end,
    },

    -- Project-wide search and replace.
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<leader>fr",
                function()
                    require("spectre").toggle()
                end,
                desc = "Find and replace in the project",
            },
        },
        opts = {},
    },
}
