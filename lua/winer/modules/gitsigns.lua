local m = require("winer.utils").map

return {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = {
        { m.ld("gp"), m.cmd("Gitsigns preview_hunk"),              desc = "[P]review Hunk" },
        { m.ld("gb"), m.cmd("Gitsigns toggle_current_line_blame"), desc = "Line [B]lame" },
        { m.ld("gr"), m.cmd("Gitsigns reset_hunk"),                desc = "[R]eset Hunk" },
        { m.ld("gl"), m.cmd("Gitsigns toggle_linehl"),             desc = "[L]ine Highlight" },
        { m.ld("gd"), m.cmd("Gitsigns toggle_deleted"),            desc = "Show [D]eleted" },
    },
    config = function()
        require("gitsigns").setup({
            numhl = true,
            current_line_blame_opts = {
                virt_text_pos = "right_align",
            },
        })
    end,
}
