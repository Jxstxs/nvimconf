---@diagnostic disable: deprecated
local m = require("work.util").map

return {
    { "wakatime/vim-wakatime",  event = "InsertEnter" },

    {
        "mfussenegger/nvim-lint",
        event = "BufWritePost"
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            window = { border = "single" }
        },
    },

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
        },
    },

    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        config = function()
            local ls = require("luasnip")
            ls.setup({
                snip_env = {
                    s = function(...)
                        local snip = ls.s(...)
                        table.insert(getfenv(2).ls_file_snippets, snip)
                    end,
                    parse = function(...)
                        local snip = ls.parser.parse_snippet(...)
                        table.insert(getfenv(2).ls_file_snippets, snip)
                    end,
                    sn = ls.snippet_node,
                    t = ls.text_node,
                    i = ls.insert_node,
                    f = ls.function_node,
                    c = ls.choice_node,
                    d = ls.dynamic_node,
                    l = require("luasnip.extras").lambda,
                    r = require("luasnip.extras").rep,
                    p = require("luasnip.extras").partial,
                    m = require("luasnip.extras").match,
                    n = require("luasnip.extras").nonempty,
                    dl = require("luasnip.extras").dynamic_lambda,
                    fmt = require("luasnip.extras.fmt").fmt,
                    fmta = require("luasnip.extras.fmt").fmta,
                    types = require("luasnip.util.types"),
                    conds = require("luasnip.extras.expand_conditions"),
                    events = require("luasnip.util.events"),
                },
            })

            require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
            vim.cmd([[
            imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            ]])
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = "InsertEnter",
    },

    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        keys = {
            { m.ld("G"), m.lua("require('neogen').generate()"), desc = "Generate Annotation" },
        },
        opts = { snippet_engine = "luasnip" },
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
