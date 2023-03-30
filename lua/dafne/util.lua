local ks = vim.keymap.set
local dopts = { silent = true }

local M = {}

M.map = {
    --- Maps to Normal Mode
    ---@param lhs string the keys for the binding
    ---@param rhs string|function the thing to execute when binding is activated
    ---@param opts table? the options for vim.keymap.set
    n = function(lhs, rhs, opts)
        ks("n", lhs, rhs, vim.tbl_deep_extend("force", dopts, opts or {}))
    end,
    --- Maps to Normal Mode
    ---@param lhs string the keys for the binding
    ---@param rhs string|function the thing to execute when binding is activated
    ---@param opts table? the options for vim.keymap.set
    i = function(lhs, rhs, opts)
        ks("i", lhs, rhs, vim.tbl_deep_extend("force", dopts, opts or {}))
    end,
    --- Maps to Normal Mode
    ---@param lhs string the keys for the binding
    ---@param rhs string|function the thing to execute when binding is activated
    ---@param opts table? the options for vim.keymap.set
    v = function(lhs, rhs, opts)
        ks("v", lhs, rhs, vim.tbl_deep_extend("force", dopts, opts or {}))
    end,
    --- Returns a String as Vim Command
    ---@param _cmd string the Command to warp
    ---@return string cmd the Vim Command
    cmd = function(_cmd)
        return ":" .. _cmd .. "<CR>"
    end,
    --- Returns a String as Vim Lua Command
    ---@param _cmd string the Command to warp
    ---@return string cmd the Vim Command
    lua = function(_cmd)
        return ":lua " .. _cmd .. "<CR>"
    end,
    --- Returns a String as Leader Keybinding
    ---@param _lhs string to keys to warp
    ---@return string lhs the Leaderkeybinding
    ld = function(_lhs)
        return "<leader>" .. _lhs
    end,
}

--- Prints a whole Table
---@param tbl table the table to print
M.pvi = function(tbl)
    print(vim.inspect(tbl))
end

return M
