local m = require("dafne.util").map

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = require("dafne.installs").ts,
                sync_install = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
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
}
