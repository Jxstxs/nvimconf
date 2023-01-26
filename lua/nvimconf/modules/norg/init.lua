
--[[ local pickers = require("nvimconf.modules.norg.pickers") ]]
local export = require("nvimconf.modules.norg.export")
local insert = require("nvimconf.modules.norg.insert")
local utils = require("nvimconf.modules.norg.utils")

local opts = {}

local setup = function(opt)
    opts = vim.tbl_deep_extend("force", opts, opt)
end

setup({
    export_dirs = {
        ""
    }
})

local M = {
    exp_file = export.single_file,
    exp_dir = export.directory,
    ins_tab = insert.table,
    toggle_tab = utils.toggle_table,

    opts = opts,
}

return M
