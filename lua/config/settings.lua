-- Per-machine settings, read from `local_settings.json`.

--- Decode one settings file, or give back nothing when it is missing or broken.
---@param name string
---@return table<string, any>
local function read(name)
    local path = vim.fs.joinpath(vim.fn.stdpath("config"), name)
    local ok, decoded = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
    end)
    return ok and decoded or {}
end

---@type table<string, any>
return vim.tbl_extend("force", read("local_settings.example.json"), read("local_settings.json"))
