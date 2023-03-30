return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "bash",
                    "c",
                    "gitignore",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "norg",
                    "rust",
                    "sql",
                    "toml",
                    "regex",
                },
                sync_install = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
}
