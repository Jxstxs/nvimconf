
local export = require("nvimconf.modules.norg.scholr.export")
local insert = require("nvimconf.modules.norg.scholr.insert")
local utils = require("nvimconf.modules.norg.scholr.utils")
local config = require("nvimconf.modules.norg.scholr.config")

local M = {
    config = {},
    --[[ config = config.config, ]]
    setup = config.setup,

    exp_file = export.single_file,
    exp_dir = export.directory,
    ins_tab = insert.table,
    toggle_tab = utils.toggle_table,
}

return M
