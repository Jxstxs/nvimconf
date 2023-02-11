local m = require("winer.utils").map

return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufRead",
        keys = {
            { m.ld("ft"), m.cmd("TodoTelescope"), desc = "Find [T]odos" },
        },
        config = function()
            require("todo-comments").setup({
                keywords = {
                    -- FIX = {
                    -- icon = " ", -- icon used for the sign, and in search results
                    -- color = "error", -- can be a hex color, or a named color (see below)
                    -- alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                    -- },
                }, merge_keywords = true,
            })
        end
    }
}
