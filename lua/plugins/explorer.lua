return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        keys = {
            { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        },
        opts = {
            hijack_directories = { enable = true, auto_open = true },

            filters = { dotfiles = false },
            git = { ignore = false },

            disable_netrw = true,
            hijack_netrw = true,

            view = { width = 25, side = "left" },

            renderer = {
                icons = {
                    show = { file = true, folder = true, folder_arrow = true, git = true },
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                    },
                },
            },

            actions = {
                open_file = { quit_on_open = false },
                use_system_clipboard = true,
            },

            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                -- Enter opens in a new tab rather than the last window.
                vim.keymap.set("n", "<CR>", api.node.open.tab, opts("Open in new tab"))

                vim.keymap.set("n", "a", api.fs.create, opts("Create file"))
                vim.keymap.set("n", "d", api.fs.remove, opts("Delete file"))
                vim.keymap.set("n", "r", api.fs.rename, opts("Rename file"))

                vim.keymap.set("n", "Y", api.fs.copy.node, opts("Copy file"))
                vim.keymap.set("n", "X", api.fs.cut, opts("Cut file"))
                vim.keymap.set("n", "p", api.fs.paste, opts("Paste file"))
            end,
        },
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = { default = true },
    },
}
