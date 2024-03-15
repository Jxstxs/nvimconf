local m = require("minimal.util").map

return {

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        keys = {
            { m.ld("Gp"), m.cmd("Gitsigns preview_hunk"),              desc = "[P]review Hunk" },
            { m.ld("Gb"), m.cmd("Gitsigns toggle_current_line_blame"), desc = "Line [B]lame" },
            { m.ld("Gr"), m.cmd("Gitsigns reset_hunk"),                desc = "[R]eset Hunk" },
            { m.ld("Gl"), m.cmd("Gitsigns toggle_linehl"),             desc = "[L]ine Highlight" },
            { m.ld("Gd"), m.cmd("Gitsigns toggle_deleted"),            desc = "Show [D]eleted" },
        },
        opts = {
            numhl = true,
        },
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        keys = {
            { m.ld("g"), m.cmd("Neogit"), desc = "Neo[g]it" },
        },
        opts = {
            graph_style = "unicode",
            disable_line_numbers = false,
        },
    },
}
