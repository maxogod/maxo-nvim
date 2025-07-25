-- Special godot lsp handler (godot hosts its LSP at localhost:6005)

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<C-i>", function()
    local saga_hover = require("lspsaga.hover")
    saga_hover:render_hover_doc()
  end, opts)

  vim.keymap.set("n", "<C-e>", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<C-r>", function() vim.lsp.buf.references() end, opts)
end

lspconfig.gdscript.setup({
  cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
  filetypes = { "gd", "gdscript" },
  root_dir = lspconfig.util.root_pattern("project.godot", ".git"),
  on_attach = on_attach,
})
