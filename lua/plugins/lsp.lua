-- LSP, the Neovim 0.11+ way: `vim.lsp.config()` / `vim.lsp.enable()`.
-- nvim-lspconfig is only here for the per-server defaults it ships; Mason
-- installs the servers themselves.
--
-- To add a server: drop `lua/lsp/<server-name>.lua` returning a config table.
-- It is merged on top of nvim-lspconfig's defaults, added to Mason's
-- ensure_installed list, and enabled. Set `install = false` in it for servers
-- that are not installable through Mason (see lua/lsp/gdscript.lua).

--- Load every server override under lua/lsp/.
---@return table<string, table>
local function load_servers()
    local servers = {}
    for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/lsp/*.lua", true)) do
        local name = vim.fn.fnamemodify(path, ":t:r")
        local ok, config = pcall(require, "lsp." .. name)
        if ok and type(config) == "table" then
            servers[name] = config
        else
            vim.notify(("Could not load lua/lsp/%s.lua"):format(name), vim.log.levels.WARN)
        end
    end
    return servers
end

return {
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = { ui = { border = "rounded" } },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        keys = {
            { "<leader>f",  vim.lsp.buf.format,                           desc = "Format buffer" },
            { "<leader>rn", vim.lsp.buf.rename,                           desc = "Rename symbol" },
            { "<leader>lr", function() require("util.lsp").restart() end, desc = "Restart every LSP client" },
            { "<leader>m",  "<Cmd>Mason<CR>",                             desc = "Open Mason" },
        },

        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("maxo_lsp_attach", { clear = true }),
                callback = function(args)
                    local util = require("util.lsp")
                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = "LSP: " .. desc })
                    end

                    map("n", "gd", function()
                        util.goto_tab("textDocument/definition")
                    end, "Go to definition (new tab)")

                    map("n", "<leader>gi", function()
                        util.goto_tab("textDocument/implementation", "textDocument/definition")
                    end, "Go to implementation (new tab)")

                    map("n", "<C-i>", function()
                        vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 30 })
                    end, "Hover documentation")

                    map("n", "<C-e>", function()
                        vim.diagnostic.open_float()
                    end, "Show diagnostic")

                    map("n", "]d", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, "Next diagnostic")

                    map("n", "[d", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, "Previous diagnostic")

                    map("n", "<C-r>", vim.lsp.buf.references, "References")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
                end,
            })
        end,

        config = function()
            local servers = load_servers()

            local ensure_installed = {}
            for name, config in pairs(servers) do
                if config.install ~= false then
                    table.insert(ensure_installed, name)
                end
                config.install = nil
                vim.lsp.config(name, config)
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                automatic_enable = true,
            })

            vim.lsp.enable(vim.tbl_keys(servers))
        end,
    },
}
