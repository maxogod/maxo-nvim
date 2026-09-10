-- Diagnostic presentation (core Neovim, no plugin involved).
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = true,
        -- everything at least as severe as INFO (i.e. all but HINT)
        severity = { min = vim.diagnostic.severity.INFO },
    },
    float = {
        border = "rounded",
        source = true,
        header = "",
        scope = "cursor",
        max_width = 80,
        wrap = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
