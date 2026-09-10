-- Compatibility shims for Neovim 0.12.
--
-- Some tree-sitter queries now hand `vim.treesitter.get_node_text` a *list* of
-- captured nodes instead of a single node, which older plugin code does not
-- expect. Normalise to a single node so those plugins keep working.
-- Delete this file once the upstream plugins are fixed.
local get_node_text = vim.treesitter.get_node_text

vim.treesitter.get_node_text = function(node, source, opts)
    if type(node) == "table" then
        node = node[#node] or node[1]
    end
    return get_node_text(node, source, opts)
end
