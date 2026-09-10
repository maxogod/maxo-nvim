-- lazy.nvim bootstrap + plugin manager setup.
-- https://lazy.folke.io/installation
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Every file under lua/plugins/ is a spec. Drop a new file in to add a
    -- plugin; nothing else needs to change.
    spec = { { import = "plugins" } },
    install = { colorscheme = { "tokyonight-night", "habamax" } },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    ui = { border = "rounded" },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

vim.keymap.set("n", "<leader>L", "<Cmd>Lazy<CR>", { desc = "Open the plugin manager" })
