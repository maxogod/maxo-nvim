local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)  -- go to definition
    vim.keymap.set("n", "<C-i>", function() vim.lsp.buf.hover() end, opts)    -- description
    vim.keymap.set("n", "<C-e>", function() vim.diagnostic.open_float() end, opts) -- diagnostics
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts) -- go to next diagnostic
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<C-r>", function() vim.lsp.buf.references() end, opts) -- code references
end)

lsp.setup()

vim.diagnostic.config({
    vim.diagnostic.config({
        virtual_text = {
            prefix = '●', -- Choose a character for the virtual text
            source = true, -- Show the source of the diagnostic
            severity = vim.diagnostic.severity.INFO, -- Show severity level
        },
        float = {
            border = 'rounded', -- Use rounded borders for floating windows
            source = true,    -- Always show the source in the floating window
            header = '',      -- Optional: remove header text
            scope = 'cursor', -- Only show diagnostics at the cursor
            max_width = 80,   -- Control maximum width for the floating window (set this according to your preference)
            wrap = true,      -- Enable wrapping of long lines in the floating window
        },
        signs = true,         -- Keep diagnostic signs on the left of the text
        underline = true,     -- Underline diagnostics
        update_in_insert = false, -- Disable diagnostic updates during insert mode
        severity_sort = true, -- Sort diagnostics by severity level
    })

})
