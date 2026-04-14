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

local function goto_tab(method, fallback_method)
    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    if not client then return end
    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    vim.lsp.buf_request(0, method, params, function(err, result)
        local empty = not result or (vim.islist(result) and #result == 0)
        if (err or empty) and fallback_method then
            goto_tab(fallback_method, nil)
            return
        end
        if err or empty then return end

        local location = vim.islist(result) and result[1] or result
        local uri = location.targetUri or location.uri
        local range = location.targetSelectionRange or location.targetRange or location.range

        if not uri or not range then
            if fallback_method then goto_tab(fallback_method, nil) end
            return
        end

        local bufnr = vim.uri_to_bufnr(uri)
        local current_buf = vim.api.nvim_get_current_buf()

        if bufnr ~= current_buf then
            vim.cmd("tabnew")
            vim.api.nvim_set_current_buf(bufnr)
        end

        vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
    end)
end

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
        goto_tab("textDocument/definition")
    end, opts)

    -- go to implementation
    vim.keymap.set("n", "<leader>gi", function()
        goto_tab("textDocument/implementation", "textDocument/definition")
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

-- Unity LSP --
vim.filetype.add({
    extension = {
        uss = 'css',
        uxml = 'xml',
    },
})

lsp.configure("omnisharp", {
    cmd = { "/home/maxo/.local/share/nvim/mason/bin/OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    root_dir = require('lspconfig.util').root_pattern("*.sln", "*.csproj"),
    enable_roslyn_analyzers = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
})

lsp.configure("cssls", {
    filetypes = { "css", "scss", "less" },
})

lsp.configure("gopls", {
    settings = {
        gopls = {
            semanticTokens = true,
        },
    },
})

lsp.configure("lemminx", {
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
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

local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_lsp.default_capabilities()

capabilities.textDocument.semanticTokens = {
    dynamicRegistration = false,
    requests = {
        range = true,
        full = {
            delta = true,
        },
    },
    tokenTypes = {},
    tokenModifiers = {},
    formats = { "relative" },
    overlappingTokenSupport = true,
    multilineTokenSupport = true,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "typescriptreact", "javascriptreact" },
    callback = function()
        vim.schedule(function()
            vim.treesitter.start(0, "tsx")
        end)
    end,
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
