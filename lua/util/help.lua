-- Cheat sheet, in a scrollable floating window.
local M = {}

local PATH = vim.fs.joinpath(vim.fn.stdpath("config"), "help.md")

---@type { win: integer, buf: integer }?
local state = nil

local function is_open()
    return state ~= nil and vim.api.nvim_win_is_valid(state.win)
end

--- Centre the window on the editor, capped so it never fills the whole screen.
---@param line_count integer
---@return vim.api.keyset.win_config
local function geometry(line_count)
    local columns, lines = vim.o.columns, vim.o.lines
    local width = math.max(40, math.min(100, columns - 4))
    local height = math.max(10, math.min(line_count, lines - 6))

    return {
        relative = "editor",
        width = width,
        height = height,
        row = math.max(0, math.floor((lines - height) / 2) - 1),
        col = math.max(0, math.floor((columns - width) / 2)),
    }
end

function M.close()
    local s = state
    if not s then
        return
    end
    state = nil

    pcall(vim.api.nvim_del_augroup_by_name, "maxo_help")

    if vim.api.nvim_win_is_valid(s.win) then
        vim.api.nvim_win_close(s.win, true)
    end
end

function M.open()
    if is_open() and state ~= nil then
        vim.api.nvim_set_current_win(state.win)
        return
    end

    if not vim.uv.fs_stat(PATH) then
        vim.notify("No cheat sheet at " .. PATH, vim.log.levels.ERROR)
        return
    end

    local lines = vim.fn.readfile(PATH)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"

    local config = geometry(#lines)
    config.style = "minimal"
    config.border = "rounded"
    config.title = " MaxoNvim Help "
    config.title_pos = "center"

    local win = vim.api.nvim_open_win(buf, true, config)
    state = { win = win, buf = buf }

    local wo = vim.wo[win][0]
    wo.wrap = true
    wo.linebreak = true
    wo.cursorline = true
    wo.conceallevel = 2
    wo.concealcursor = "nc"
    wo.winhighlight = "NormalFloat:Normal,FloatBorder:Comment,FloatTitle:Title"

    for _, key in ipairs({ "q", "<Esc>", "<leader>h" }) do
        vim.keymap.set("n", key, M.close, {
            buffer = buf,
            nowait = true,
            desc = "Close the cheat sheet",
        })
    end

    local group = vim.api.nvim_create_augroup("maxo_help", { clear = true })

    vim.api.nvim_create_autocmd("VimResized", {
        group = group,
        callback = function()
            if is_open() then
                vim.api.nvim_win_set_config(state.win, geometry(#lines))
            end
        end,
    })

    vim.api.nvim_create_autocmd("WinClosed", {
        group = group,
        pattern = tostring(win),
        callback = M.close,
    })
end

function M.toggle()
    if is_open() then
        M.close()
    else
        M.open()
    end
end

return M
