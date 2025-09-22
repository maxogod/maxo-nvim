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

    -- go to definition
    vim.keymap.set("n", "gd", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
    end, opts)
    -- vim.keymap.set("n", "<C-i>", function() vim.lsp.buf.hover() end, opts)         -- description
    vim.keymap.set("n", "<C-i>", function()
        local saga_hover = require("lspsaga.hover")
        saga_hover:render_hover_doc()
    end, opts)
    vim.keymap.set("n", "<C-e>", function() vim.diagnostic.open_float() end, opts) -- diagnostics
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)     -- go to next diagnostic
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<C-r>", function() vim.lsp.buf.references() end, opts)    -- code references
end)

lsp.configure("omnisharp", {
    cmd = { "/home/maxo/.local/share/nvim/mason/bin/OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    root_dir = require('lspconfig.util').root_pattern("*.sln", "*.csproj"),
    enable_roslyn_analyzers = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
})

lsp.configure("ltex", {
    filetypes = { "latex", "tex" },
    settings = {
        ltex = {
            language = "es",
            additionalRules = {
                motherTongue = "es",
                enabled = { "es", "en-US" }
            },
            dictionary = {},
            disabledRules = {
                ["es"] = {},
            },
        }
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        source = true,
        severity = vim.diagnostic.severity.INFO,
    },
    float = {
        border = 'rounded',
        source = true,
        header = '',
        scope = 'cursor',
        max_width = 80,
        wrap = true,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

require("lspsaga").setup({
    ui = {
        border = "rounded",
    },
    hover = {
        max_width = 80,
        max_height = 30,
    },
    lightbulb = {
        enable = false,
    },
    scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
    },
})
