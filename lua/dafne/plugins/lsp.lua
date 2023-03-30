local m = require("dafne.util").map

return {
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            {
                "jay-babu/mason-null-ls.nvim",
                dependencies = {
                    "jose-elias-alvarez/null-ls.nvim",
                },
            },
        },
        build = ":MasonUpdate",
        keys = {
            { m.ld("M"), m.cmd("Mason"), desc = "Open [M]ason" },
        },
        config = function()
            local to_install = require("dafne.installs")

            require("mason").setup({
                ui = { border = "single", },
            })

            require("mason-lspconfig").setup({
                ensure_installed = to_install["lsps"],
                automatic_installation = true,
            })

            require("mason-null-ls").setup({
                ensure_installed = to_install["null"],
                automatic_installation = true,
                automatic_setup = true,
            })

            require('mason-null-ls').setup_handlers()

            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, v in ipairs(to_install["lsps"]) do
                require("lspconfig")[v].setup({
                    capabilities = capabilities,
                })
            end
        end,
    },

    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        keys = {
            { m.ld("d"),  m.cmd("Lspsaga lsp_finder"),                 desc = "Lsp Finder" },
            { m.ld("la"), m.cmd("Lspsaga code_action"),                desc = "Code Action" },
            { m.ld("lr"), m.cmd("Lspsaga rename ++project"),           desc = "Rename" },
            { m.ld("lp"), m.cmd("Lspsaga peek_definition"),            desc = "Peek Def" },
            { m.ld("lg"), m.cmd("Lspsaga goto_definition"),            desc = "Goto Def" },
            { m.ld("lw"), m.cmd("Lspsaga show_workspace_diagnostics"), desc = "Workspace Diagnostics" },
            { m.ld("lo"), m.cmd("Lspsaga outline"),                    desc = "Outline" },
            { m.ld("lf"), m.lua("vim.lsp.buf.format({async=true})"),   desc = "Rename" },
        },
        config = true,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    },
}
