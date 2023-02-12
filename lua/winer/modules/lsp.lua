local m = require("winer.utils").map

return {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        { "neovim/nvim-lspconfig" },
        "mfussenegger/nvim-dap",
        {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                local nl = require("null-ls")
                nl.setup({
                    sources = {
                        nl.builtins.formatting.stylua,
                        nl.builtins.diagnostics.luacheck,
                    },
                })
            end,
        },
    },
    keys = {
        -- Normal Mode
        { m.ld("lf"), m.cmd("lua vim.lsp.buf.format()"),      desc = "[F]ormat" },
        { m.ld("ld"), m.cmd("lua vim.lsp.buf.diagnostics()"), desc = "[D]iagnostics" },
        { m.ld("la"), m.cmd("lua vim.lsp.buf.code_action()"), desc = "Code [A]ction" },
        { m.ld("lh"), m.cmd("lua vim.lsp.buf.hover()"),       desc = "[H]over" },

        -- Visual Mode
        -- { m.ld("lf"), m.cmd("lua vim.lsp.buf.range_format()"), desc = "[F]ormat" },
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
    end,
}
