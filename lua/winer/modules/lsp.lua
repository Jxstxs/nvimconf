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
            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "ThePrimeagen/refactoring.nvim",
            {
                "ray-x/navigator.lua",
                event = { "BufReadPre", "BufNewFile" },
                dependencies = {
                    -- stylua: ignore start
                    { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
                    -- stylua: ignore end
                    { "nvim-treesitter/nvim-treesitter-refactor" },
                },
                keys = {
                    { m.ld("ls"), m.cmd("lua require('navigator.symbols').document_symbols()"), desc = "[S]ymbols" },
                    {
                        m.ld("ld"),
                        m.cmd("lua require('navigator.definition').definition()"),
                        desc = "[D]efinition",
                    },
                    {
                        m.ld("lD"),
                        m.cmd("lua require('navigator.definition').definition_preview()"),
                        desc = "[D]efinition Preview",
                    },

                    {
                        m.ld("la"),
                        m.cmd("lua require('navigator.codeAction').code_action()"),
                        desc = "Code [A]ctions",
                    },
                    {
                        m.ld("la"),
                        m.cmd("lua require('navigator.codeAction').range_code_action()"),
                        mode = "v",
                        desc = "Code [A]ctions",
                    },
                    { m.ld("lr"), m.cmd("lua require('navigator.rename').rename()"), desc = "[R]ename" },
                    {
                        m.ld("lh"),
                        m.cmd("lua vim.lsp.buf.hover()"),
                        desc = "[H]over (Double)",
                    },
                    {
                        m.ld("li"),
                        m.cmd("lua vim.lsp.buf.implementation()"),
                        desc = "[I]mplementation",
                    },
                    {
                        m.ld("lf"),
                        function()
                            vim.lsp.buf.format({
                                filter = function(client)
                                    return client.name == "null-ls"
                                end,
                            })
                        end,
                        desc = "[F]ormat",
                    },
                    {
                        m.ld("lF"),
                        m.cmd("lua require('navigator.formatting').range_format()"),
                        desc = "[F]ormat Motion",
                    },
                    { m.ld("lR"), m.cmd("lua require('navigator.reference').async_ref()"), desc = "[R]eferences" },

                    -- { key = "gL", func = require("navigator.diagnostics").show_diagnostics, desc = "show_diagnostics", },
                    -- { key = "<Leader>dt", func = require("navigator.diagnostics").toggle_diagnostics, desc = "toggle_diagnostics", },
                    -- { key = "]d", func = vim.diagnostic.goto_next, desc = "next diagnostics" },
                    -- { key = "[d", func = vim.diagnostic.goto_prev, desc = "prev diagnostics" },
                    -- { key = "]r", func = require("navigator.treesitter").goto_next_usage, desc = "goto_next_usage" },
                    -- { key = "[r", func = require("navigator.treesitter").goto_previous_usage, desc = "goto_previous_usage", },
                    -- { key = "<Leader>k", func = require("navigator.dochighlight").hi_symbol, desc = "hi_symbol" },
                    -- { key = "<Leader>gt", func = require("navigator.treesitter").buf_ts, desc = "buf_ts" },
                    -- { key = "<Leader>gT", func = require("navigator.treesitter").bufs_ts, desc = "bufs_ts" },
                    -- { key = "<Leader>ct", func = require("navigator.ctags").ctags, desc = "ctags" },
                    -- { key = "<Space>ff", func = vim.lsp.buf.range_formatting, mode = "v", desc = "range format", },
                    -- { key = "<Space>wl", func = require("navigator.workspace").list_workspace_folders, desc = "list_workspace_folders", },
                },
                config = function()
                    require("navigator").setup({
                        default_mapping = false,
                        keymaps = {},
                        border = "single",
                        ts_fold = true,
                        transparency = 100,
                        lsp_signature_help = true,
                        signature_help_cfg = { debug = false },
                        lsp = {
                            rename = {
                                style = "floating-preview", -- 'floating' | 'floating-preview' | 'inplace-preview'
                                show_result = true,
                                confirm = "<S-CR>",
                                cancel = "<S-BS>",
                            },
                            code_lens_action = { sign = false },
                            hover = false, -- bind hover action to keymap; there are other options e.g. noice, lspsaga provides lsp hover
                            format_on_save = false,
                            format_options = { async = true },
                            disable_nulls_codeaction_sign = false,
                            disply_diagnostic_qf = false, -- always show quickfix if there are diagnostic errors
                            diagnostic_update_in_insert = false,
                            diagnostic_scrollbar_sign = { "▃", "▆", "█" }, -- nil to disable {'╍', 'ﮆ'}
                            neodev = false,
                        },
                        mason = true,
                        icons = {
                            code_action_icon = "🏏", -- "",
                            code_lens_action_icon = "👓",
                            diagnostic_head = "🐛",
                            diagnostic_err = "📛",
                            diagnostic_warn = "👎",
                            diagnostic_info = [[👩]],
                            diagnostic_hint = [[💁]],
                            diagnostic_head_severity_1 = "🈲",
                            diagnostic_head_severity_2 = "☣️",
                            diagnostic_head_severity_3 = "👎",
                            diagnostic_head_description = "👹",
                            diagnostic_virtual_text = "🦊",
                            diagnostic_file = "🚑",
                            value_changed = "📝",
                            value_definition = "🐶🍡", -- it is easier to see than 🦕
                            side_panel = {
                                section_separator = "",
                                line_num_left = "",
                                line_num_right = "",
                                inner_node = "├○",
                                outer_node = "╰○",
                                bracket_left = "⟪",
                                bracket_right = "⟫",
                            },
                            match_kinds = {
                                associated = "🤝",
                                namespace = "🚀",
                                type = " ",
                                field = "🏈",
                                module = "📦",
                                flag = "🎏",
                            },
                            treesitter_defult = "🌲",
                        },
                    })
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
