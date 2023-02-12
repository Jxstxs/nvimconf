return {
    "folke/which-key.nvim",
    config = function()

        vim.o.timeout = true
        vim.o.timeoutlen = 300

        local wk = require("which-key")

        wk.setup({
            plugins = { spelling = {
                enabled = true,
                suggestions = 30,
            }, },
            window = { border = "single", },
            layout = { align = "center", },
        })

        -- Normal Mode
        wk.register({
            V = "[V]im Stuff",
            f = "[F]inder Stuff",
            ["fg"] = "[G]it Stuff",
            g = "[G]it Stuff",
        }, { mode = "n", prefix = "<leader>" })

        -- Visual Mode
        wk.register({
            T = { name = "Tester" }
        }, { mode = "v", prefix = "<leader>" })
    end,
}
