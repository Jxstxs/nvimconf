local m = require("winer.utils").map

return {
    { "jcdickinson/codeium.nvim", event = "InsertEnter" },
    {
        "jackMort/ChatGPT.nvim",
        opts = {
            yank_register = "+",
            settings_window = {
                border = {
                    style = "single",
                },
            },
            chat_window = {
                border = {
                    style = "single",
                },
            },
            chat_input = {
                border = {
                    style = "single",
                },
            },
        },
        keys = {
            { m.ld("Cc"), m.cmd("ChatGPT"), desc = "[C]hatGPT" },
        },
    },
}
