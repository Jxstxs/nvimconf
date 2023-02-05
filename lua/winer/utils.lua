local ks = vim.keymap.set
local dopts = {}

local M = {
    map = {
        n = function(lhs, rhs, opts)
            ks("n", lhs, rhs, opts or dopts)
        end,
        i = function(lhs, rhs, opts)
            ks("i", lhs, rhs, opts or dopts)
        end,
        v = function(lhs, rhs, opts)
            ks("v", lhs, rhs, opts or dopts)
        end,
        cmd = function(_cmd) return ":" .. _cmd .. "<CR>" end
    },
    toggle_lazygit = function()
        if lgT == nil then
---@diagnostic disable-next-line: lowercase-global
            lgT = require("toggleterm.terminal").Terminal:new({
---@diagnostic disable-next-line: undefined-global
                cmd = "lazygit -p " .. vim.fn.getcwd(),
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "double",
                }
            })
        end
        lgT:toggle()
    end
}

return M
