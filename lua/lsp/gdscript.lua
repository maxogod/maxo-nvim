-- Godot hosts its own language server; there is nothing for Mason to install,
-- we just connect to the editor on localhost:6005 while it is running.
return {
    install = false,
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    filetypes = { "gd", "gdscript" },
    root_markers = { "project.godot", ".git" },
}
