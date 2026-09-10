return {
    -- `:G <any git command>`
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Gblame" },
    },

    -- Inline blame for the current line
    {
        "f-person/git-blame.nvim",
        cmd = { "GitBlameToggle", "GitBlameEnable" },
        keys = {
            { "<leader>gb", "<Cmd>GitBlameToggle<CR>",        desc = "Toggle git blame" },
            { "<leader>gB", "<Cmd>GitBlameOpenCommitURL<CR>", desc = "Open commit in browser" },
        },
        opts = {
            enabled = false,
            message_template = "<author> | <date> | <sha>",
            highlight_group = "Comment",
        },
    },

    -- Git diff markers by line
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "┃" },
                change       = { text = "▍" },
                delete       = { text = "▁" },
                topdelete    = { text = "▔" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
        },
    },
}
