math.randomseed(os.time())

--- Returns a merged table from opts and defaults
---@param opts table?
---@return table
local section = function(opts)
    local defaults = {
        icon = " ",
        icon_hl = "Title",
        desc = "",
        desc_hl = "String",
        key = "",
        keymap = "",
        key_hl = "Number",
        action = "",
    }

    return vim.tbl_deep_extend("force", defaults, opts)
end

return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
        require("dashboard").setup({
            theme = "doom",
            config = {
                header = require("winer.db-logo")[math.random(1, #require("winer.db-logo"))],
                center = {
                    section({
                        desc = "Find Files",
                        key = "f",
                        keymap = "SPC f f",
                        action = "lua require('telescope.builtin').find_files()",
                    }),
                    section({
                        desc = "Recent Files",
                        key = "r",
                        keymap = "SPC f o",
                        action = "lua require('telescope.builtin').oldfiles()",
                    }),
                    section({
                        desc = "Edit Config",
                        key = "c",
                        keymap = "SPC V c",
                        action = "e $MYVIMRC",
                    }),
                    section({
                        desc = "Open Lazy",
                        key = "l",
                        keymap = "SPC L",
                        action = "Lazy",
                    }),
                    section({
                        desc = "Quit",
                        key = "q",
                        keymap = "Z Z",
                        action = "qa!",
                    }),
                },
                footer = { "Dave Raves All Day Long" },
            },
        })
    end,
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
}
