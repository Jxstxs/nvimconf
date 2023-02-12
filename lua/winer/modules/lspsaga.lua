return {
    "glepnir/lspsaga.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    event = "BufRead",
    config = function()
        require("lspsaga").setup({})
    end,
}
