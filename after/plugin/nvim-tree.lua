-- Sidebar file explore

require("nvim-tree").setup({
    -- Automatically open the tree when opening Neovim
    hijack_directories = {
        enable = true,
        auto_open = true,
    },

    -- Show hidden files
    filters = { dotfiles = false },

    -- Disable netrw (vim's file explorer)
    disable_netrw = true,
    hijack_netrw = true,

    view = {
        width = 25,    -- Sidebar width
        side = "left", -- Can also be "right"
    },

    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "", -- default file icon
                symlink = "",
                folder = {
                    arrow_closed = "", -- arrow when folder is closed
                    arrow_open = "", -- arrow when folder is open
                    default = "", -- default folder icon
                    open = "", -- open folder icon
                    empty = "", -- empty folder
                    empty_open = "", -- empty folder, open
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
    },

    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        -- Define key mappings
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Remap Enter key to open file in a new tab
        vim.keymap.set("n", "<CR>", api.node.open.tab, opts("Open in New Tab"))
        vim.keymap.set("n", "a", api.fs.create, opts("Create File"))
        vim.keymap.set("n", "d", api.fs.remove, opts("Delete File"))
        vim.keymap.set("n", "r", api.fs.rename, opts("Rename File"))
    end,
})

require('nvim-web-devicons').setup {
    default = true, -- enable default icons globally
}
