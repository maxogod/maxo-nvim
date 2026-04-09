-- Neovim 0.12: some captures are lists; normalize to a single node for get_node_text.
local get_node_text = vim.treesitter.get_node_text
vim.treesitter.get_node_text = function(node, source, opts)
    if type(node) == "table" then
        node = node[#node] or node[1]
    end
    return get_node_text(node, source, opts)
end

require 'nvim-treesitter.config'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "jsx",
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
