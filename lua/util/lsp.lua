local M = {}

--- Jump to an LSP location, opening it in a new tab when it lives in another
--- buffer. Falls back to `fallback_method` when the first request comes back
--- empty (e.g. implementation -> definition).
---@param method string LSP request method
---@param fallback_method? string
function M.goto_tab(method, fallback_method)
    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    if not client then
        -- No server here: fall back to Vim's own `gd` rather than doing
        -- nothing, which just looks like a broken keymap.
        vim.cmd("normal! gd")
        return
    end

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

    vim.lsp.buf_request(0, method, params, function(err, result)
        local empty = not result or (vim.islist(result) and #result == 0)
        if err or empty then
            if fallback_method then
                M.goto_tab(fallback_method, nil)
            else
                vim.notify(
                    ("No %s found"):format(method:match("[^/]+$")),
                    vim.log.levels.INFO
                )
            end
            return
        end

        local location = vim.islist(result) and result[1] or result
        local uri = location.targetUri or location.uri
        local range = location.targetSelectionRange or location.targetRange or location.range

        if not uri or not range then
            if fallback_method then
                M.goto_tab(fallback_method, nil)
            end
            return
        end

        local bufnr = vim.uri_to_bufnr(uri)
        vim.fn.bufload(bufnr)

        if bufnr ~= vim.api.nvim_get_current_buf() then
            vim.cmd.tabnew()
            vim.api.nvim_set_current_buf(bufnr)
        end

        vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
    end)
end

--- Stop every LSP client and reload the open buffers so they re-attach.
function M.restart()
    local current = vim.api.nvim_get_current_buf()

    for _, client in ipairs(vim.lsp.get_clients()) do
        client:stop(true)
    end

    vim.defer_fn(function()
        vim.cmd("bufdo edit")
        vim.api.nvim_set_current_buf(current)
    end, 500)
end

return M
