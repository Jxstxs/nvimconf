local ks = vim.keymap.set

local dopts = {
    silent = true,
}

local M = {
    map = {
        n = function(lhs, rhs, opts)
            ks("n", lhs, rhs, vim.tbl_deep_extend("force", dopts, opts or {}))
        end,
        i = function(lhs, rhs, opts)
            ks("i", lhs, rhs, vim.tbl_deep_extend("force", dopts, opts or {}))
        end,
        v = function(lhs, rhs, opts)
            ks("v", lhs, rhs, vim.tbl_deep_extend("force", dopts, opts or {}))
        end,
        cmd = function(_cmd)
            return ":" .. _cmd .. "<CR>"
        end,
        ld = function(_lhs)
            return "<leader>" .. _lhs
        end,
    },
    pvi = function(type)
        print(vim.inspect(type))
    end,
}

return M
