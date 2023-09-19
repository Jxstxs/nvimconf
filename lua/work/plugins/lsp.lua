local m = require("work.util").map

return {
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            {
                "SmiteshP/nvim-navbuddy",
                keys = { { m.ld("N"), m.lua("require('nvim-navbuddy').open()"), desc = "Navbuddy" } },
                dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
                opts = {
                    lsp = { auto_attach = true },
                    source_buffer = {
                        follow_node = true,
                        highlight = true,
                    },
                },
            },
        },
        build = ":MasonUpdate",
        keys = {
            { m.ld("M"), m.cmd("Mason"), desc = "Open [M]ason" },
        },
        config = function()
            local to_install = require("work.installs")

            require("mason").setup({
                ui = { border = "single" },
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
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        keys = {
            { m.ld("d"), m.cmd("Lspsaga lsp_finder"), desc = "Lsp Finder" },
            { m.ld("la"), m.cmd("Lspsaga code_action"), desc = "Code Action" },
            { m.ld("lr"), m.cmd("Lspsaga rename ++project"), desc = "Rename" },
            { m.ld("lp"), m.cmd("Lspsaga peek_definition"), desc = "Peek Def" },
            { m.ld("lg"), m.cmd("Lspsaga goto_definition"), desc = "Goto Def" },
            { m.ld("lw"), m.cmd("Lspsaga show_workspace_diagnostics"), desc = "Workspace Diagnostics" },
            { m.ld("lo"), m.cmd("Lspsaga outline"), desc = "Outline" },
            { m.ld("lh"), m.cmd("Lspsaga hover_doc"), desc = "Hover" },
            { m.ld("lf"), m.lua("vim.lsp.buf.format({async=true})"), desc = "Rename" },
        },
        config = function()
            require("lspsaga").setup({})

            -- local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
            -- vim.api.nvim_create_autocmd("CursorHold", {
            --     callback = function()
            --            vim.api.nvim_exec("Lspsaga show_line_diagnostics ++unfocus", false)
            --         -- FIX: look at on how to make it noice with flirt
            --         -- vim.diagnostic.open_float()
            --     end,
            --     group = diag_float_grp,
            -- })
        end,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
}