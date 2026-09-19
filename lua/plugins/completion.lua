-- blink.cmp replaces nvim-cmp and its source plugins. It is intentionally not
-- lazy-loaded: it registers the LSP client capabilities other plugins rely on.
return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = {
                preset = "none",
                ["<Down>"] = { "select_next", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Tab>"] = { "accept", "fallback" },
                ["<Esc>"] = { "cancel", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
                ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
            },
            appearance = { nerd_font_variant = "mono" },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                list = { selection = { preselect = true, auto_insert = false } },
            },
            signature = { enabled = true },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
