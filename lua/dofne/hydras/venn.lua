local hydra = require("hydra")

local hydra_hints = require("winer.hydras.hydra_hints")["venn"]
local m = require("winer.utils").map

return hydra({
        name = "Draw Diagram",
        hint = hydra_hints,
        config = {
            color = "pink",
            invoke_on_body = true,
            hint = {
                border = "single",
            },
            on_enter = function()
                vim.cmd([[setlocal ve=all]])
            end,
            on_exit = function()
                vim.cmd([[setlocal ve=]])
            end,
        },
        mode = "n",
        body = m.ld("Hv"), -- FIX: need better way for this!!!
        heads = {
            { "H",     "<C-v>h:VBox<CR>" },
            { "J",     "<C-v>j:VBox<CR>" },
            { "K",     "<C-v>k:VBox<CR>" },
            { "L",     "<C-v>l:VBox<CR>" },
            { "f",     ":VBox<CR>",      { mode = "v" } },
            { "<ESC>", nil,              { exit = true } },
        },
    })
