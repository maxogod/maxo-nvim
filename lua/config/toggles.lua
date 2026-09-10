-- Small runtime toggles shared between keymaps and autocommands.
local M = {}

--- Format the buffer on every write, or not.
function M.format_on_save()
    vim.g.format_on_save = not vim.g.format_on_save
    vim.notify("Format on save: " .. (vim.g.format_on_save and "enabled" or "disabled"))
end

--- Let the terminal background show through, or paint the colorscheme's own.
function M.transparency()
    vim.g.transparent_background = not vim.g.transparent_background
    require("tokyonight").setup({
        transparent = vim.g.transparent_background,
        styles = {
            sidebars = vim.g.transparent_background and "transparent" or "dark",
            floats = vim.g.transparent_background and "transparent" or "dark",
        },
    })
    vim.cmd.colorscheme("tokyonight-night")
end

--- Soft-wrap long lines, or not.
function M.wrap()
    vim.opt_local.wrap = not vim.wo.wrap
end

return M
