local m = require("winer.utils").map

return {
    {
        "famiu/bufdelete.nvim",
        keys = {
            { m.ld("q"), m.cmd("Bdelete"), desc = "Close Buffer" },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                disable_in_macro = true,
                disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
            })
        end,
    },
    {
        "wakatime/vim-wakatime",
        event = "InsertEnter",
    },
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
    {
        "danymat/neogen",
        keys = {
            { m.ld("Ca"), m.cmd("Neogen"), desc = "[A]nnotation" },
        },
        opts = { snippet_engine = "luasnip" },
    },
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        keys = {
            {
                m.ld("Cp"),
                function()
                    if require("peek").is_open() then
                        require("peek").close()
                    else
                        require("peek").open()
                    end
                end,
                desc = "Toggle [P]review",
            },
        },
        config = function()
            require("peek").setup({
                syntax = false,
                app = "browser",
            })
        end,
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        event = { "BufRead *.norg", "BufNewFile *.norg" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neorg/neorg-telescope",
            {
                "lukas-reineke/headlines.nvim",
                config = function()
                    vim.cmd([[highlight Headline1 guibg=#36189b gui=italic,underline]])
                    -- vim.cmd([[highlight Headline2 guibg=#21262d guifg=#1e2718 gui=italic]])
                    -- vim.cmd([[highlight Headline3 guibg=#3e2718 guifg=#1e2718 gui=italic]])
                    -- vim.cmd([[highlight Headline4 guibg=#41262d guifg=#1e2718 gui=italic]])
                    -- vim.cmd([[highlight Headline5 guibg=#5e2718 guifg=#1e2718 gui=italic]])
                    -- vim.cmd([[highlight Headline6 guibg=#61262d guifg=#1e2718 gui=italic]])

                    -- vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])

                    -- vim.cmd([[highlight Quote guibg=#2c1c1c]])

                    -- vim.cmd([[highlight Dash guibg=#D19A66]])
                    -- vim.cmd([[highlight DoubleDash guibg=#D29A66]])

                    require("headlines").setup({
                        norg = {
                            fat_headlines = false,
                            fat_headline_upper_string = " ", -- "▃",
                            headline_highlights = {
                                "Headline1",
                                "Headline2",
                                "Headline3",
                                "Headline4",
                                "Headline5",
                                "Headline6",
                            },
                        },
                    })
                end,
            },
        },
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.esupports.metagen"] = {
                    config = {
                        type = "auto",
                    },
                },
                -- ["core.presenter"] = { config = { zen_mode = "truezen" } },
                ["core.export"] = {},
                ["core.norg.concealer"] = {
                    config = {
                        icons = {
                            heading = {
                                level_1 = { icon = "﮴ " },
                                level_2 = { icon = "  " },
                                level_3 = { icon = "   " },
                                level_4 = { icon = "    " },
                                level_5 = { icon = "     " },
                                level_6 = { icon = "      " },
                            },
                            list = {
                                level_1 = { icon = "﬌" },
                                level_2 = { icon = "  ﬌" },
                                level_3 = { icon = "   ﬌" },
                                level_4 = { icon = "    ﬌" },
                                level_5 = { icon = "     ﬌" },
                                level_6 = { icon = "      ﬌" },
                            },
                        },
                    },
                },
                ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
                ["core.integrations.telescope"] = {}, -- FIX: Need Config?
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/repos/personal/notes/",
                            scholr = "~/repos/personal/scholr/",
                        },
                        index = "index.norg", -- The name of the main (root) .norg file
                    },
                },
                ["core.norg.manoeuvre"] = { config = {} },
            },
        },
    },
    {
        "anuvyklack/hydra.nvim",
        dependencies = {
            { "jbyuki/venn.nvim" },
        },
        keys = {
            { m.ld("Hv"), m.cmd("lua require('winer.hydras').activate_hydra('venn')"), desc = "[V]enn Diagrams" },
            { m.ld("HH"), m.cmd("lua require('winer.hydras').activate_hydra()"), desc = "Choose [H]ydra" },
        },
    },
}
