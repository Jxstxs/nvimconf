
local M = {}

local key = require("nvimconf.core.keys")
local nmap = key.nmap
local cmd = key.cmd
local opts = key.opts({ silent = true })

nmap({
    {"<S-h>", cmd("BufferLineCyclePrev"), opts},
    {"<S-l>", cmd("BufferLineCycleNext"), opts},
})
M.keys = {
    n = {
        opts = {},
        mappings = {}
    },
    v = {
        opts = {},
        mappings = {}
    }
}

return M
