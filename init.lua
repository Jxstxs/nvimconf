require("winer.options")
require("winer.keymaps")
require("winer.lazy")

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

local term = require("toggleterm.terminal").Terminal
local lazy = term:new({ cmd = "lazygit", hidden = true })
function LAZY_TOGGLE()
    lazy:toggle()
end

local ranger = term:new({ cmd = "ranger", hidden = true })
function RANGER_TOGGLE()
    ranger:toggle()
end
