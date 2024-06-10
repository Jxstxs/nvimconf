local m = require("minimal.util").map

return {
    {
        "nvim-neorg/neorg",
        version = "v7.0.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-neorg/neorg-telescope", dependencies = { "nvim-telescope/telescope.nvim" } },
            "nvim-treesitter/nvim-treesitter",
            "vhyrro/luarocks.nvim",
        },
        -- build = ":Neorg sync-parsers",
        ft = "norg",
        keys = {
            { m.ld("nf"), m.cmd("norm ggVG="),                    desc = "Formats a Neorg File" },
            { m.ld("nT"), m.cmd("Neorg tangle current-file"),     desc = "[T]angle Code to file" },
            { m.ld("nF"), m.cmd("Telescope neorg find_linkable"), desc = "[F]inds Everything" },
        },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.keybinds"] = {
                        config = {
                            hook = function(keybinds)
                                keybinds.remap_event("norg", "n", "<Space>ng", "core.looking-glass.magnify-code-block")
                            end,
                        },
                    },
                    ["core.esupports.metagen"] = { config = { type = "auto" } },
                    ["core.export"] = { config = {} },
                    ["core.export.markdown"] = { config = { extensions = { "all" } } },
                    ["core.completion"] = { config = { engine = "nvim-cmp" } },
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond",
                            folds = false,
                            dim_code_blocks = {
                                conceal = false,
                                content_only = false,
                            },
                        },
                    },
                    ["core.integrations.telescope"] = {},
                },
            })

            local _ = vim.api.nvim_create_augroup("winerau", { clear = true })

            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = "winerau",
                pattern = { "norg" },
                callback = function()
                    vim.opt_local.wrap = true
                    vim.opt_local.spell = true
                    vim.opt_local.spelllang = "de,en"
                    vim.api.nvim_set_hl(0, "@Written", { italic = true })
                end,
            })
        end,
    },

    {
        "dhruvasagar/vim-table-mode",
        keys = {
            { m.ld("ntt"), m.cmd("TableModeToggle"), desc = "Toggle Table Mode" },
        },
    },
}
