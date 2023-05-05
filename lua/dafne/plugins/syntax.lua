local m = require("dafne.util").map

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/playground" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = require("dafne.installs").ts,
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                playground = {
                    enable = true,
                },
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite", "CursorHold" },
                },
            })
        end,
    },

    {
        "m-demare/hlargs.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "BufReadPre",
    },

    {
        "haringsrob/nvim_context_vt",
        keys = {
            { m.ld("Cc"), m.cmd("NvimContextVtToggle"), desc = "Toggle NvimContextVt" },
        },
    },

    {
        "jubnzv/virtual-types.nvim",
        event = "BufReadPre",
        -- FIX: add to on_attach
    },
}
