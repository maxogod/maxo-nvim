require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "c",
        "lua",
        "rust",
        "go",
        "python",
        "java",
        "vim",
        "vimdoc",
        "query"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
    },
}
