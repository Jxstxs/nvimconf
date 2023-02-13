return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            autotag = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                -- "gitignore",
                "java",
                "json",
                "json5",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                -- "sql",
                "vim",
            },
            sync_install = false,
            auto_install = false,
            ignore_install = {},
            highlight = { enable = true, additional_vim_regex_highlighting = false },
        })
    end,
}
