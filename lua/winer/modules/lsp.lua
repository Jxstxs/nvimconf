
return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "jose-elias-alvarez/null-ls.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()

        for _, server in ipairs(require("winer.lsps")) do
            require("lspconfig")[server].setup({})
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = require("winer.lsps"),
            automatic_installation = true,
        })
        local nl = require("null-ls")
        nl.setup({
            sources = {nl.builtins.completion.spell}
        })
    end
}
