return {
    settings = {
        basedpyright = {
            disableOrganizeImports = true, -- ruff owns imports
            analysis = {
                typeCheckingMode = "standard",
                diagnosticMode = "openFilesOnly",
            },
        },
    },
}
