local m = require("minimal.util").map

return {
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        build = ":MasonUpdate",
        keys = {
            { m.ld("M"), m.cmd("Mason"), desc = "Open [M]ason" },
        },
        config = function()
            local to_install = require("minimal.installs")

            require("mason").setup({
                ui = {  order = "single" },
            })

            require("mason-lspconfig").setup({
                ensure_installed = to_install["lsps"],
                automatic_installation = true,
            })

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, v in ipairs(to_install["lsps"]) do
                require("lspconfig")[v].setup({
                    capabilities = capabilities,
                })
            end
        end,
    },

    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        keys = {
            -- TODO: Redo keybind commands
            { m.ld("d"), m.cmd("Lspsaga lsp_finder"), desc = "Lsp Finder" },
            { m.ld("la"), m.cmd("Lspsaga code_action"), desc = "Code Action" },
            { m.ld("lr"), m.cmd("Lspsaga rename ++project"), desc = "Rename" },
            { m.ld("lp"), m.cmd("Lspsaga peek_definition"), desc = "Peek Def" },
            { m.ld("lg"), m.cmd("Lspsaga goto_definition"), desc = "Goto Def" },
            { m.ld("lw"), m.cmd("Lspsaga show_workspace_diagnostics"), desc = "Workspace Diagnostics" },
            { m.ld("lo"), m.cmd("Lspsaga outline"), desc = "Outline" },
            { m.ld("lh"), m.cmd("Lspsaga hover_doc"), desc = "Hover" },
            { m.ld("lf"), m.lua("vim.lsp.buf.format({async=true})"), desc = "Format" },
            { m.ld("li"), m.lua("vim.lsp.buf.implementation({async=true})"), desc = "Implementation" },
        },
        opts = {

        },
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
}
