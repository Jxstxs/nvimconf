return {
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    lsp_doc_border = true,
                },
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "UIEnter",
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("github-theme").setup({ theme_style = "dark_default" })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")

            require("indent_blankline").setup({
                show_end_of_line = true,
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },
}
