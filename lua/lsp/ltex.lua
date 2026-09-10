-- Grammar/spell checking for prose and LaTeX.
return {
    filetypes = { "latex", "tex", "plaintex", "markdown", "text" },
    settings = {
        ltex = {
            language = "en-US",
            enabled = { "latex", "tex", "plaintex", "markdown", "text" },
        },
    },
}
