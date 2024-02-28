local m = require("minimal.util").map

return {
    {
        "EdenEast/nightfox.nvim",
        config = function()
            -- require("nightfox").setup({ options = { styles = { comments = "italic", }, }, })
        end,
    },

    {
        "Sly-Harvey/radium.nvim",
        config = function()
            require("radium").setup({})
        end
    },

    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                long_message_to_split = false,
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "single",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        keys = {
            { m.ld("gp"), m.cmd("Gitsigns preview_hunk"),              desc = "[P]review Hunk" },
            { m.ld("gb"), m.cmd("Gitsigns toggle_current_line_blame"), desc = "Line [B]lame" },
            { m.ld("gr"), m.cmd("Gitsigns reset_hunk"),                desc = "[R]eset Hunk" },
            { m.ld("gl"), m.cmd("Gitsigns toggle_linehl"),             desc = "[L]ine Highlight" },
            { m.ld("gd"), m.cmd("Gitsigns toggle_deleted"),            desc = "Show [D]eleted" },
        },
        opts = {
            numhl = true,
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require("ibl").setup({ })
        end,
    },

    { "stevearc/dressing.nvim" },
}
