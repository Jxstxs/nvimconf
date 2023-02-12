local m = require("winer.utils").map

return {
    { "famiu/bufdelete.nvim", keys = {
        { m.ld("q"), m.cmd("Bdelete"), desc = "Close Buffer" },
    } },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({ disable_in_macro = true })
        end,
    },
    { "wakatime/vim-wakatime", event = "InsertEnter" },
}
