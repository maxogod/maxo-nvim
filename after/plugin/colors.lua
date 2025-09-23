vim.g.tokyonight_flavour = "night"
vim.cmd.colorscheme("tokyonight-night")

-- Dont paint background by default (comment if you dont want to inherit background from terminal)
local background_removed = false

function ToggleBackground()
    if background_removed then
        -- Re-add backgrounds (reset to defaults or your chosen values)
        vim.cmd [[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NvimTreeNormal guibg=#1a1b26 ctermbg=NONE
      highlight NvimTreeNormalNC guibg=#1a1b26 ctermbg=NONE
      highlight NvimTreeEndOfBuffer guibg=#1a1b26 guifg=#1a1b26
      highlight NvimTreeWinSeparator guibg=#1a1b26 guifg=#444444
    ]]
        background_removed = false
    else
        -- Remove backgrounds
        vim.cmd [[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NvimTreeNormal guibg=NONE ctermbg=NONE
      highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
      highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE
      highlight NvimTreeWinSeparator guibg=NONE ctermbg=NONE guifg=#444444
    ]]
        background_removed = true
    end
end

ToggleBackground()
