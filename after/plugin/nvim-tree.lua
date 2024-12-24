-- Sidebar file explorer

require("nvim-tree").setup({
    -- Automatically open the tree when opening Neovim
    hijack_directories = {
        enable = true,
        auto_open = true,
    },

    -- Disable netrw (recommended)
    disable_netrw = true,
    hijack_netrw = true,

    -- Auto-resize the tree to fit its content
    view = {
        width = 25,            -- Sidebar width
        side = "left",         -- Can also be "right"
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
})

require('nvim-web-devicons').setup {
    default = true,         -- enable default icons globally
}
