local m = require("dafne.util").map

return {
    {
        "nvim-neorg/neorg",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-neorg/neorg-telescope", dependencies = { "nvim-telescope/telescope.nvim" } },
            "nvim-treesitter/nvim-treesitter",
        },
        build = ":Neorg sync-parsers",
        ft = "norg",
        keys = {
            { m.ld("nf"), m.cmd("norm ggVG="), desc = "Formats a Neorg File" },
            { m.ld("njj"), m.cmd("Neorg journal today"), desc = "todays [j]ournal" },
            { m.ld("njt"), m.cmd("Neorg journal tomorrow"), desc = "[t]omorrows journal" },
            { m.ld("njy"), m.cmd("Neorg journal yesterday"), desc = "[Y]esterdays Journal" },
            { m.ld("njT"), m.cmd("Neorg journal template"), desc = "[T]emplate Journal" },
            { m.ld("njc"), ":Neorg journal custom ", desc = "[C]ustom Journal" },
            { m.ld("nn"), m.cmd("Neorg news new"), desc = "[N]ews in Neorg" },
            { m.ld("nN"), m.cmd("Neorg news all"), desc = "[N]ews in Neorg (All)" },
            { m.ld("nt"), m.cmd("Neorg tangle current-file"), desc = "[T]angle Code to file" },
            { m.ld("nu"), m.cmd("Neorg upgrade current-file"), desc = "[U]pgrades Current File" },
            { m.ld("nU"), m.cmd("Neorg upgrade current-directory"), desc = "[U]pgrades Current Directory" },
            { m.ld("nF"), m.cmd("Telescope neorg find_linkable"), desc = "[F]inds Everything" },
        },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.keybinds"] = {
                        config = {
                            hook = function(keybinds)
                                -- keybinds.unmap("norg", "n", "gtd")
                                -- keybinds.map("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
                                -- keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
                                -- keybinds.remap_event( "norg", "n", "<C-Space>", "core.norg.qol.todo_items.todo.task_done")
                                -- keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>t")

                                keybinds.remap_event("norg", "n", "<Space>ng", "core.looking-glass.magnify-code-block")
                            end,
                        },
                    },
                    ["core.esupports.metagen"] = { config = { type = "auto" } },
                    ["core.journal"] = {
                        config = {
                            journal_folder = "/doc/journal",
                            workspace = "scholr",
                        },
                    },
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
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/repos/personal/notes/",
                                scholr = "~/repos/personal/scholr/",
                            },
                            index = "index.norg",
                        },
                    },
                    ["core.integrations.telescope"] = {},
                },
            })

            ---@diagnostic disable-next-line: unused-local
            local autogroup = vim.api.nvim_create_augroup("winerau", { clear = true })

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
        "NFrid/due.nvim",
        ft = "norg",
        keys = {
            { m.ld("nd"), m.lua("require('due_nvim').redraw(0)"), desc = "Redraw Dues" },
            { m.ld("nc"), m.lua("require('due_nvim').clear(0)"), desc = "Clear Dues" },
        },
    },
}
