local m = require("winer.utils").map

return {
    -- Pretty Fold
    {
        "anuvyklack/pretty-fold.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local folder = vim.api.nvim_create_augroup("folder", { clear = true })
            vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
                group = "folder",
                pattern = { "*.lua", "*.md", "*.c", "*.h", "*.norg" },
                callback = function()
                    vim.cmd("set fen")
                end,
            })

            require("pretty-fold").setup({
                sections = {
                    left = {
                        "content",
                    },
                    right = {
                        " ",
                        "number_of_folded_lines",
                        ": ",
                        "percentage",
                        " ",
                        function(config)
                            return config.fill_char:rep(3)
                        end,
                    },
                },
                fill_char = "•",
                keep_indentation = true,
                -- List of patterns that will be removed from content foldtext section.
                stop_words = {
                    "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
                },
                matchup_patterns = {
                    { "^%s*do$",       "end" }, -- `do ... end` blocks
                    { "^%s*if",        "end" },
                    { "^%s*for",       "end" },
                    { "function%s*%(", "end" },
                    { "{",             "}" },
                    { "%(",            ")" },
                    { "%[",            "]" },
                },
            })
        end,
    },

    -- Fold Preview
    {
        "anuvyklack/fold-preview.nvim",
        dependencies = { "anuvyklack/keymap-amend.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("fold-preview").setup({
                border = "single",
            })
        end,
    },

    -- Fold
    {
        "jghauser/fold-cycle.nvim",
        keys = {
            { m.ld("Fo"), m.cmd("lua require('fold-cycle').open()"),      desc = "[O]pen Next" },
            { m.ld("FO"), m.cmd("lua require('fold-cycle').open_all()"),  desc = "[O]pen All" },
            { m.ld("Fc"), m.cmd("lua require('fold-cycle').close()"),     desc = "[C]lose Next" },
            { m.ld("FC"), m.cmd("lua require('fold-cycle').close_all()"), desc = "[C]lose All" },
        },
    },
}
