-- Global autocommands. Plugin-specific ones live next to their plugin spec.
local augroup = function(name)
    return vim.api.nvim_create_augroup("maxo_" .. name, { clear = true })
end

-- Format on save, unless toggled off with <leader>tf.
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("format_on_save"),
    pattern = "*",
    callback = function(args)
        if vim.g.format_on_save then
            vim.lsp.buf.format({ bufnr = args.buf, async = false })
        end
    end,
})

-- Briefly highlight whatever was just yanked.
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Greeter, only when Neovim was started with no file arguments.
vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("greeter"),
    callback = function()
        require("config.greeter").show()
    end,
})

-- Unity source files that Neovim does not know about.
vim.filetype.add({
    extension = {
        uss = "css",
        uxml = "xml",
    },
})
