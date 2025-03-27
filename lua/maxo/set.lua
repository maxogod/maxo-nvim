-- line numbers
vim.opt.nu = true

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- tabs to spaces
vim.opt.expandtab = true

-- adjust indentation based on syntax
vim.opt.smartindent = true

-- wrapping
vim.opt.wrap = false

-- search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- allow 24-bit colors
vim.opt.termguicolors = true

-- time after which the CursorHold autocommand is triggered
vim.opt.updatetime = 50

-- Make find (/<str>) case insensitive
vim.o.ignorecase = true
vim.o.smartcase = true

-- Format on save
vim.g.format_on_save = true

function ToggleFormatOnSave()
    vim.g.format_on_save = not vim.g.format_on_save
    if vim.g.format_on_save then
        print("Format on Save: Enabled")
    else
        print("Format on Save: Disabled")
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if vim.g.format_on_save then
            vim.lsp.buf.format()
        end
    end,
})

-- folding
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99

