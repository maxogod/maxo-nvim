-- Needs the dotnet SDK on PATH; the server itself comes from Mason,
-- which puts its bin directory on PATH, so nvim-lspconfig's default `cmd`
-- resolves on its own.
return {
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
        },
        RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
        },
    },
}
