local m = require("winer.utils").map

return {
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            {
                "mfussenegger/nvim-dap",
                dependencies = { "rcarriga/nvim-dap-ui" },
            },
            "jose-elias-alvarez/null-ls.nvim",
            {
                "jay-babu/mason-null-ls.nvim",
                config = function()
                    local null_ls = require("null-ls")
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
            for _, server in ipairs(require("winer.lsps")) do
                require("lspconfig")[server].setup({})
            end

            require("mason").setup({
                ui = { border = "single" },
            })

            require("mason-lspconfig").setup({
                ensure_installed = require("winer.lsps"),
                automatic_installation = true,
            })

            require("mason-null-ls").setup({
                ensure_installed = {},
                automatic_installation = false,
                automatic_setup = true,
            })

            require("mason-nvim-dap").setup({
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
            require("mason-nvim-dap").setup_handlers()
        end,
    },
}
