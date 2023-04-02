local m = require("dafne.util").map

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
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic",
                        strings = "italic",
                    },
                },
            })
            vim.opt.background = "dark"
            vim.cmd("colorscheme carbonfox")
        end,
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
            { m.ld("gp"), m.cmd("Gitsigns preview_hunk"), desc = "[P]review Hunk" },
            { m.ld("gb"), m.cmd("Gitsigns toggle_current_line_blame"), desc = "Line [B]lame" },
            { m.ld("gr"), m.cmd("Gitsigns reset_hunk"), desc = "[R]eset Hunk" },
            { m.ld("gl"), m.cmd("Gitsigns toggle_linehl"), desc = "[L]ine Highlight" },
            { m.ld("gd"), m.cmd("Gitsigns toggle_deleted"), desc = "Show [D]eleted" },
        },
        opts = {
            numhl = true,
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require("indent_blankline").setup({
                show_end_of_line = true,
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },

    {
        "tamton-aquib/flirt.nvim",
        enabled = true,
        config = function()
            require("flirt").setup({
                override_open = true,
                close_command = "Q",
                default_move_mappings = false,
                default_resize_mappings = false,
                default_mouse_mappings = true,
            })
        end,
    },

    { "stevearc/dressing.nvim" },

    {
        "glepnir/dashboard-nvim",
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
        opts = {
            theme = "doom",
            config = {
                header = {
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "██████╗░░█████╗░███████╗███╗░░██╗███████╗",
                    "██╔══██╗██╔══██╗██╔════╝████╗░██║██╔════╝",
                    "██║░░██║███████║█████╗░░██╔██╗██║█████╗░░",
                    "██║░░██║██╔══██║██╔══╝░░██║╚████║██╔══╝░░",
                    "██████╔╝██║░░██║██║░░░░░██║░╚███║███████╗",
                    "╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚══╝╚══════╝",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                },
                center = {
                    section({
                        desc = "Find Files",
                        key = "f",
                        keymap = "SPC f f",
                        action = "lua require('telescope').extensions.menufacture.find_files()",
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
                footer = { "Dafne Raves All Day Long" },
            },
        },
    },
}
