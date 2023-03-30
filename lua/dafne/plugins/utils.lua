local m = require("dafne.util").map

return {
    { "folke/neodev.nvim", },

    { "wakatime/vim-wakatime", event = "InsertEnter", },

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { m.ld("e"), m.lua("require('neo-tree').float()"), desc = "Neotree" },
        },
        opts = {
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
                }
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
                follow_current_file = true,
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
                    }
                }
            },
        },
    },


    {
        "numToStr/Comment.nvim",
        event = "InsertEnter",
    },

    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        keys = {
            {m.ld("g"), m.lua("require('neogen').generate()"), desc = "Generate Annotation"},
        },
        opts = { snippet_engine = "luasnip" },
    },

    {
        "jcdickinson/codeium.nvim",
        event = "InsertEnter",
        dependencies = {
            { "jcdickinson/http.nvim", build = "cargo build --workspace --release" },
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = true,
    },
}
