local m = require("minimal.util").map

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "mrbjarksen/neo-tree-diagnostics.nvim",
        },
        keys = {
            { m.ld("e"), m.cmd("Neotree float"), desc = "Neotree" },
        },
        opts = {
            sources = {
                "filesystem",
                "diagnostics",
                "git_status",
            },
            close_if_last_window = true,
            popup_border_style = "single",
            sort_case_insensitive = true,
            window = {
                mappings = {
                    ["l"] = "open",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["H"] = "prev_source",
                    ["L"] = "next_source",
                },
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                },
            },
            buffers = {
                follow_current_file = {
                    enable = true,
                },
                group_empty_dirs = true,
                show_unloaded = true,
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["a"] = "git_add_file",
                        ["u"] = "git_unstage_file",
                        ["c"] = "git_commit",
                        ["p"] = "git_push",
                    },
                },
            },
            diagnostics = {
                auto_preview = true,
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "InsertEnter",
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    {
        "phaazon/hop.nvim",
        keys = {
            { m.ld("h"), m.cmd("HopWord"),  desc = "Hop Word" },
            { m.ld("H"), m.cmd("HopChar1"), desc = "Hop Char" },
        },
        config = true,
    },

    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = { { m.ld("ft"), m.cmd("TodoTelescope"), desc = "Search Todos" } },
        opts = { highlight = { multiline = false } },
    },
}
