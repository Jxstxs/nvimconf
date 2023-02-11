return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            autotag = {
                enable = true
            },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                -- "css",
                -- "gitignore",
                "html",
                "http",
                "java",
                "javascript",
                "json",
                "json5",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "php",
                "python",
                "regex",
                -- "sql",
                -- "sxhkdrc",
                "toml",
                "typescript",
                "vim",
            },
            sync_install = false,
            auto_install = false,
            ignore_install = {},
            highlight = { additional_vim_regex_highlighting = false, },
        })
    end
}
