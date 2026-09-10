-- nvim-treesitter `main` branch: it installs parsers and nothing else, so
-- highlighting/indentation are started per-buffer from the autocommand below.
local ENSURE_INSTALLED = {
    "bash",
    "c",
    "c_sharp",
    "css",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup({})

            local installed = ts.get_installed()
            local missing = vim.tbl_filter(function(lang)
                return not vim.tbl_contains(installed, lang)
            end, ENSURE_INSTALLED)
            if #missing > 0 then
                ts.install(missing)
            end

            local function start(buf, lang)
                if not vim.api.nvim_buf_is_valid(buf) then
                    return
                end
                if not pcall(vim.treesitter.start, buf, lang) then
                    return
                end
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                if vim.api.nvim_get_current_buf() == buf then
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end

                -- C#'s parser still misses a few constructs; keep the classic
                -- regex syntax underneath it as a fallback.
                if vim.bo[buf].filetype == "cs" then
                    vim.bo[buf].syntax = "ON"
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("maxo_treesitter", { clear = true }),
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang then
                        return
                    end

                    if vim.tbl_contains(ts.get_installed(), lang) then
                        start(args.buf, lang)
                    elseif vim.tbl_contains(ts.get_available(), lang) then
                        -- auto_install: fetch the parser, then highlight
                        local ok, task = pcall(ts.install, lang)
                        if ok and task then
                            pcall(function()
                                task:await(function()
                                    vim.schedule(function()
                                        start(args.buf, lang)
                                    end)
                                end)
                            end)
                        end
                    end
                end,
            })
        end,
    },

    -- Auto close/rename HTML & JSX tags.
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false,
            },
        },
    },

    -- Colour-matched brackets.
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("rainbow-delimiters.setup").setup({})
        end,
    },
}
