local m = require("minimal.util").map

return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = require("minimal.installs").ts,
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                textobjects = {
                    enable = true,
                    lsp_interop = {
                        enable = true,
                        border = "rounded",
                        peek_definition_code = {
                            [m.ld("pf")] = "@function.outer",
                            [m.ld("pc")] = "@class.outer",
                            [m.ld("pp")] = "@parameter.outer",
                            [m.ld("pa")] = "@assignment.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            [m.ld("sp")] = "@parameter.inner",
                        },
                        swap_previous = {
                            [m.ld("sP")] = "@parameter.inner",
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true,
                        lookbehind = true,
                        keymaps = {
                            ab = "@block.outer",
                            ib = "@block.inner",
                            ac = "@class.outer",
                            ic = "@class.inner",
                            aC = "@conditional.outer",
                            iC = "@conditional.inner",
                            af = "@function.outer",
                            ["if"] = "@function.inner",
                            al = "@loop.outer",
                            il = "@loop.inner",
                        }
                    },
                }
            })
        end,
    },

    {
        "m-demare/hlargs.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "BufReadPre",
    },
}
