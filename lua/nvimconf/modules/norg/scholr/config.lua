
local M = {}

M.config = {
    std = {},
    export_dirs = {},
}

M.setup = function(opt)
    require("nvimconf.modules.norg.scholr").config = vim.tbl_deep_extend("force", M.config, opt)
end

return M
