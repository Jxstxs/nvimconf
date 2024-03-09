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

            local on_attach = function(client, bufnr)
                local function bsk(...) vim.api.nvim_buf_set_keymap(bufnr, "n", ...) end

                local opts = { noremap = true, silent = true }

                vim.diagnostic.config({
                    float = { border = "rounded", focusable = false }
                })

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
                bsk(m.ld("lDd"), m.lua("require('telescope.builtin').diagnostics({bufnr=0})"),
                    u.merge_tbl(opts, { desc = "Buffer [D]iagnostics" }))
                bsk(m.ld("lDD"), m.lua("require('telescope.builtin').diagnostics()"),
                    u.merge_tbl(opts, { desc = "Workspace [D]iagnostics" }))

                bsk(m.ld("lh"), m.lua("vim.lsp.buf.hover()"),
                    u.merge_tbl(opts, { desc = "[H]over" }))
                bsk(m.ld("lH"), m.lua("vim.diagnostic.open_float()"),
                    u.merge_tbl(opts, { desc = "[H]over Diagnostic" }))
                bsk(m.ld("lf"), m.lua("vim.lsp.buf.format()"),
                    u.merge_tbl(opts, { desc = "[F]ormat" }))
                bsk(m.ld("lR"), m.lua("vim.lsp.buf.rename()"),
                    u.merge_tbl(opts, { desc = "[R]ename" }))
                bsk(m.ld("ln"), m.lua("vim.diagnostic.goto_next()"),
                    u.merge_tbl(opts, { desc = "[N]ext Diagnostic" }))
                bsk(m.ld("lN"), m.lua("vim.diagnostic.goto_prev()"),
                    u.merge_tbl(opts, { desc = "Prev Diagnostic" }))
                bsk(m.ld("la"), m.lua("vim.lsp.buf.code_action()"),
                    u.merge_tbl(opts, { desc = "Code [A]ction" }))

                if client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "#ff0000" })
                    vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "#ffa500" })
                    vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "#00ffff" })

                    vim.api.nvim_create_augroup("lsp_doc_highlight", { clear = true })
                    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_doc_highlight" })

                    vim.api.nvim_create_autocmd("CursorHold",
                        {
                            callback = vim.lsp.buf.document_highlight,
                            group = "lsp_doc_highlight",
                            desc =
                            "Highlight Current Symbol"
                        })
                    vim.api.nvim_create_autocmd("CursorMoved",
                        {
                            callback = vim.lsp.buf.clear_references,
                            group = "lsp_doc_highlight",
                            desc =
                            "clear Highlighted Symbol"
                        })
                end
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
