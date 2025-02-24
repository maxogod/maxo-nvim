-- Wrap code around chars

-- remove default spaces between brackets [ a ] -> [a]
require("nvim-surround").setup({
    surrounds = {
        ["["] = {
            add = { "[", "]" },
        },
        ["("] = {
            add = { "(", ")" },
        },
        ["{"] = {
            add = { "{", "}" },
        },
    },
})

