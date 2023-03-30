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

--- Opens a Telescope Picker
---@param _picker table the settings for the Picker
---@diagnostic disable-next-line: 214
M.get_selection = function(_picker)
    local selector = require("telescope.pickers").new(_picker)
    selector:find()
end

M.picker = {
    --- Creates an Telescope Finder with a Table as Entries
    ---@param values table the Entries to be displayed
    ---@param returner fun(result: any): nil the function which handles the results
    ---@return string[] entires the selected Entries
    table = function(values, returner)
        local finders = require("telescope.finders")
        local sorters = require("telescope.sorters")
        local actions = require("telescope.actions")
        local state = require("telescope.actions.state")

        return {
            finder = finders.new_table(values),
            sorter = sorters.get_generic_fuzzy_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
                map("i", "<CR>", function()
                    local selection = state.get_current_picker(prompt_bufnr):get_multi_selection()
                    actions.close(prompt_bufnr)
                    returner(selection)
                end)

                return true
            end,
        }
    end,
}

--- Warps a function in a Corutine
---@param fnc function the function to run
M.warpper = function(fnc)
    coroutine.resume(coroutine.create(function()
        fnc()
    end))
end

-- returns the path to the file without the file name
M.get_file_path = function()
    local file = vim.api.nvim_buf_get_name(0)
    local separatorIndex = file:find("/[^/]*$")
    if separatorIndex then
        return file:sub(1, separatorIndex)
    else return file
    end
end

M.replace = function()
    local under_cursor = vim.fn.expand("<cword>")
    vim.ui.input({prompt = "Replace with: "}, function(result)
        os.execute(" grep -r -l " .. under_cursor .. " * | xargs sed -i 's/" .. under_cursor .. "/" .. result .. "/g'")
    end)
end

return M
