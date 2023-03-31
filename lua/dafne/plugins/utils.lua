---@diagnostic disable: deprecated
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
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
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

    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = true,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function ()
            require("nvim-autopairs").setup({})
        end
    },
}
