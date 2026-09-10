-- Start screen banner, echoed on an empty startup.
local M = {}

local BANNER = [[
 ___      ___       __       ___  ___   ______    _____  ___  ___      ___  __     ___      ___
|"  \    /"  |     /""\     |"  \/"  | /    " \  (\"   \|"  \|"  \    /"  ||" \   |"  \    /"  |
 \   \  //   |    /    \     \   \  / // ____  \ |.\\   \    |\   \  //  / ||  |   \   \  //   |
 /\\  \/.    |   /' /\  \     \\  \/ /  /    ) :)|: \.   \\  | \\  \/. ./  |:  |   /\\  \/.    |
|: \.        |  //  __'  \    /\.  \(: (____/ // |.  \    \. |  \.    //   |.  |  |: \.        |
|.  \    /:  | /   /  \\  \  /  \   \\        /  |    \    \ |   \\   /    /\  |\ |.  \    /:  |
|___|\__/|___|(___/    \___)|___/\___|\"_____/    \___|\____\)    \__/    (__\_|_)|___|\__/|___|
]]

local MESSAGE = "press <space>h for help!"

local MIN_WIDTH = 106
local MIN_HEIGHT = 14

local function centered(text, width)
    local lines = {}
    for line in text:gmatch("[^\r\n]+") do
        local padding = math.max(0, math.floor((width - #line) / 2))
        table.insert(lines, string.rep(" ", padding) .. line)
    end
    return lines
end

function M.show()
    vim.api.nvim_set_hl(0, "MaxoBlue", { fg = "#61afef", bold = true })
    vim.api.nvim_set_hl(0, "MaxoGreen", { fg = "#98c379", bold = true })

    local width = vim.o.columns
    local height = vim.o.lines

    local banner, gap = BANNER, 2
    if width < MIN_WIDTH or height < MIN_HEIGHT then
        banner, gap = "MaxoNvim", 1
    end

    local banner_lines = centered(banner, width)
    local message_lines = centered(MESSAGE, width)

    local chunks = {}
    for _, line in ipairs(banner_lines) do
        table.insert(chunks, { line .. "\n", "MaxoBlue" })
    end
    table.insert(chunks, { string.rep("\n", gap) })
    for _, line in ipairs(message_lines) do
        table.insert(chunks, { line .. "\n", "MaxoGreen" })
    end

    local content = #banner_lines + gap + #message_lines
    local margin = math.max(0, math.floor((height - 1 - content) / 2))
    table.insert(chunks, { string.rep("\n", margin) })

    vim.api.nvim_echo(chunks, false, {})
end

return M
