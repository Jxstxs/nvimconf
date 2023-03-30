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

            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, v in ipairs(to_install["lsps"]) do
                require("lspconfig")[v].setup({
                    capabilities = capabilities,
                })
            end
        end,
    },
}
