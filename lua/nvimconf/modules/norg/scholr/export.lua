local config = require("nvimconf.modules.norg.scholr.config").config

--- exports a given file from neorg to markdown
---@param src string #Path to the source file
---@param dest string #Path to the destination
local export_file = function(src, dest)
    print(src, dest)
end

local M = {}

--- Exports a Single File to the choosen Directory
---@param current_file boolean
M.single_file = function(current_file)
    if current_file then
        --[[ print(vim.inspect(config.export_dirs)) ]]
        export_file(vim.api.nvim_buf_get_name(0), config.std.export)
        print(vim.inspect(config))
    else
        print("[n.exp] picker not implemented")
    end
end

--- Exports a whole Directory to choosen Directory
---@param current_workspace boolean
M.directory = function(current_workspace)
    print("[n.exp] not implemented")
end

return M
