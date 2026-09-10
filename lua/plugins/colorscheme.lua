return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000, -- load before everything else so no other theme flashes
        opts = function()
            local transparent = vim.g.transparent_background
            return {
                style = "night",
                transparent = transparent,
                styles = {
                    sidebars = transparent and "transparent" or "dark",
                    floats = transparent and "transparent" or "dark",
                },
            }
        end,
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-night")

            vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#449d5b" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#6183bb" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e7768e" })
        end,
    },
}
