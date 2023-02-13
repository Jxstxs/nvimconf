local utils = require("winer.utils")
local m = utils.map

-- Setting <leader>
vim.keymap.set("", "<Space>", "<NOP>")
vim.g.mapleader = " "

-- Save Bindings
m.n(m.ld("w"), m.cmd("w"), { desc = "Save Current file" })
m.n(m.ld("W"), m.cmd("wa!"), { desc = "Save All files" })

-- Lazy Bindings
m.n(m.ld("L"), m.cmd("Lazy"), { desc = "Open [L]azy UI" })

-- Exit Vim
m.n(m.ld("Q"), m.cmd("qa!"), { desc = "[Q]uit Nvim" })

-- Reset Hightlights after search
m.n(m.ld("h"), m.cmd("nohls"), { desc = "Reset [H]ighlights" })

-- Windows Problem => <C-V>
m.n("<M-v>", "<C-v>", { desc = "Windows Problem" })

-- Source Current File
m.n("<leader>Vs", function()
    vim.notify("Sourcing: " .. vim.api.nvim_buf_get_name(0), vim.log.levels.INFO)
    vim.cmd("source %")
end, { desc = "[S]ource Current file" })

-- Open Config (init)
m.n("<leader>Vc", function()
    vim.api.nvim_set_current_dir(vim.fn.stdpath("config"))
    vim.cmd("e $MYVIMRC")
end, { desc = "Edit [C]onfig" })

-- Reloading a Plugin
m.n(m.ld("Vr"), function()
    utils.warpper(function()
        local _plugins = require("lazy.core.config").plugins
        local plugins = {}
        for plugin, _ in pairs(_plugins) do
            table.insert(plugins, plugin)
        end

        local corot = assert(coroutine.running())
        vim.schedule(function()
            utils.get_selection(utils.picker.table(plugins, function(result)
                local _f = {}
                for _, v in ipairs(result) do
                    table.insert(_f, v[1])
                end
                coroutine.resume(corot, _f)
            end))
        end)

        local to_reload = coroutine.yield()
        for _, plugin in ipairs(to_reload) do
            require("lazy.core.loader").reload(plugin)
        end
    end)
end, { desc = "[R]eload Plugin" })

-- Better Pasting
-- FIX: map.v("p", "_dP") dont work (just pastes the selected text)

-- Better Shifting
m.v("<", "<gv")
m.v(">", ">gv")

-- Buffer "Shifting"
m.n("<S-h>", m.cmd("bprev"), { desc = "Previous Buffer" })
m.n("<S-l>", m.cmd("bnext"), { desc = "Next Buffer" })

-- Escape Insertmode
m.i("jj", "<ESC>")

-- Window Bindings
m.n("<C-h>", "<C-w>h")
m.n("<C-j>", "<C-w>j")
m.n("<C-k>", "<C-w>k")
m.n("<C-l>", "<C-w>l")

-- Insert Movement
m.i("<C-h>", "<Left>")
m.i("<C-j>", "<Down>")
m.i("<C-k>", "<Up>")
m.i("<C-l>", "<Right>")
