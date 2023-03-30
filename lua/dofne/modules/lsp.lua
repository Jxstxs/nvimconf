local m = require("dofne.utils").map

return {
    {
        -- FIX: Cleanup
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "jose-elias-alvarez/null-ls.nvim",
            {
                "jay-babu/mason-null-ls.nvim",
                config = function()
                    require("crates").setup({
                        null_ls = {
                            enabled = true,
                            name = "creates.nvim",
                        },
                    })
                end,
            },
            "jay-babu/mason-nvim-dap.nvim",
            {
                "glepnir/lspsaga.nvim",
                event = "LspAttach",
                config = function()
                    require("lspsaga").setup({})
                end,
            },
        },
        keys = {
            { m.ld("M"), m.cmd("Mason"), desc = "[M]ason" },
        },
        config = function()
            for _, server in ipairs(require("dofne.lsps")) do
                require("lspconfig")[server].setup({})
            end

            require("mason").setup({
                ui = { border = "single" },
            })

            require("mason-lspconfig").setup({
                ensure_installed = require("dofne.lsps"),
                automatic_installation = true,
            })

            require("mason-null-ls").setup({
                ensure_installed = {},
                automatic_installation = false,
                automatic_setup = true,
            })

            local nl = require("null-ls")
            nl.setup({
                sources = {
                    nl.builtins.hover.printenv,
                    nl.builtins.code_actions.refactoring,
                },
                border = "single",
            })
            require("mason-null-ls").setup_handlers()
        end,
    },
}
