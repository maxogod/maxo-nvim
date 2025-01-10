-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Theme
    use {
        "folke/tokyonight.nvim",
        as = "tokyonight",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.tokyonight_style = "night" -- "night", "storm", "moon", "day"
            vim.cmd [[colorscheme tokyonight]]
        end
    }

    -- File Explorer
    use('nvim-tree/nvim-web-devicons')
    use('nvim-tree/nvim-tree.lua')

    -- GH Copilot
    use "github/copilot.vim"

    -- Tree Sitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- Show git status, diff, etc (:G <command>)
    use('tpope/vim-fugitive')

    -- Multiple cursors
    use {
        'mg979/vim-visual-multi'
    }

    -- Commenting
    use 'tpope/vim-commentary'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                opts = {
                    ensure_installed = 'gopls'
                }
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
end)
