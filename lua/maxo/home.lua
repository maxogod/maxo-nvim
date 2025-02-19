-- Home View

local function center_text(text)
    local lines = {}
    local term_width = vim.o.columns

    for line in text:gmatch("[^\r\n]+") do
        local padding = math.max(0, math.floor((term_width - #line) / 2))
        table.insert(lines, string.rep(" ", padding) .. line)
    end

    return lines
end

-- Colors
vim.cmd("highlight MaxoBlue guifg=#61afef gui=bold")  -- Blue
vim.cmd("highlight MaxoGreen guifg=#98c379 gui=bold") -- Green

local banner = [[
 ___      ___       __       ___  ___   ______    _____  ___  ___      ___  __     ___      ___ 
|"  \    /"  |     /""\     |"  \/"  | /    " \  (\"   \|"  \|"  \    /"  ||" \   |"  \    /"  |
 \   \  //   |    /    \     \   \  / // ____  \ |.\\   \    |\   \  //  / ||  |   \   \  //   |
 /\\  \/.    |   /' /\  \     \\  \/ /  /    ) :)|: \.   \\  | \\  \/. ./  |:  |   /\\  \/.    |
|: \.        |  //  __'  \    /\.  \(: (____/ // |.  \    \. |  \.    //   |.  |  |: \.        |
|.  \    /:  | /   /  \\  \  /  \   \\        /  |    \    \ |   \\   /    /\  |\ |.  \    /:  |
|___|\__/|___|(___/    \___)|___/\___|\"_____/    \___|\____\)    \__/    (__\_|_)|___|\__/|___|
]]
local message = "press <space>h for help!"

local centered_banner = center_text(banner)
local centered_message = center_text(message)

for _, line in ipairs(centered_banner) do
    vim.api.nvim_echo({ { line, "MaxoBlue" } }, false, {})
end

print("\n\n\n\n")

for _, line in ipairs(centered_message) do
    vim.api.nvim_echo({ { line, "MaxoGreen" } }, false, {})
end

print("\n\n\n")

