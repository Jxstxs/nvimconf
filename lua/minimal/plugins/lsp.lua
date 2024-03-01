local u = require("minimal.util")
local m = u.map

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
            local lspconfig = require("lspconfig")

            require("mason").setup({
                ui = { order = "single" },
            })

            require("mason-lspconfig").setup({
                ensure_installed = to_install["lsps"],
                automatic_installation = true,
            })

            local on_attach = function(_, bufnr)
                local function bsk(...) vim.api.nvim_buf_set_keymap(bufnr, "n", ...) end

                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                local opts = { noremap = true, silent = true }

                bsk(m.ld("ld"), m.lua("require('telescope.builtin').lsp_definitions()"),
                    u.merge_tbl(opts, { desc = "[D]efinitions" }))
                bsk(m.ld("ls"), m.lua("require('telescope.builtin').lsp_document_symbols()"),
                    u.merge_tbl(opts, { desc = "Doc [S]mybols" }))
                bsk(m.ld("lS"), m.lua("require('telescope.builtin').lsp_workspace_symbols()"),
                    u.merge_tbl(opts, { desc = "Workspace [S]mybols" }))
                bsk(m.ld("li"), m.lua("require('telescope.builtin').lsp_implementations()"),
                    u.merge_tbl(opts, { desc = "[I]mplementations" }))
                bsk(m.ld("lr"), m.lua("require('telescope.builtin').lsp_references()"),
                    u.merge_tbl(opts, { desc = "[R]eferences" }))
                bsk(m.ld("lD"), m.lua("require('telescope.builtin').lsp_diagnostics()"),
                    u.merge_tbl(opts, { desc = "[D]iagnostics" }))

                bsk(m.ld("lh"), m.lua("vim.lsp.buf.hover()"),
                    u.merge_tbl(opts, { desc = "[H]over" }))
                bsk(m.ld("lf"), m.lua("vim.lsp.buf.format()"),
                    u.merge_tbl(opts, { desc = "[F]ormat" }))
                bsk(m.ld("lR"), m.lua("vim.lsp.buf.rename()"),
                    u.merge_tbl(opts, { desc = "[R]ename" }))
                bsk(m.ld("ln"), m.lua("vim.diagnostic.goto_next()"),
                    u.merge_tbl(opts, { desc = "[N]ext Diagnostic" }))
                bsk(m.ld("lN"), m.lua("vim.diagnostic.goto_prev()"),
                    u.merge_tbl(opts, { desc = "Prev Diagnostic" }))
                bsk(m.ld("la"), m.lua("vim.lsp.codelens.run()"),
                    u.merge_tbl(opts, { desc = "Code [A]ction" }))
            end

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, v in ipairs(to_install["lsps"]) do
                lspconfig[v].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
        end,
    },
}
