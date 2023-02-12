local m = require("winer.utils").map

return {
    { "famiu/bufdelete.nvim", keys = {
        { m.ld("q"), m.cmd("Bdelete"), desc = "Close Buffer" },
    } },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({ disable_in_macro = true })
        end,
    },
    { "wakatime/vim-wakatime", event = "InsertEnter" },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300

            local wk = require("which-key")

            wk.setup({
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 30,
                    },
                },
                window = { border = "single" },
                layout = { align = "center" },
            })

            -- Normal Mode
            wk.register({
                V = "[V]im Stuff",
                f = "[F]inder Stuff",
                ["fg"] = "[G]it Stuff",
                g = "[G]it Stuff",
                l = "[L]SP Stuff",
            }, { mode = "n", prefix = "<leader>" })

            -- Visual Mode
            wk.register({
                T = { name = "Tester" },
            }, { mode = "v", prefix = "<leader>" })
        end,
    },
}
