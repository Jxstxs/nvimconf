local m = require("winer.utils").map

-- local register = require("which-key").register

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

-- Vim/User Bindings

m.n("<leader>Vs", function()
    vim.notify("Sourcing: " .. vim.api.nvim_buf_get_name(0), vim.log.levels.INFO)
    vim.cmd("source %")
end, { desc = "[S]ource Current file" })

m.n("<leader>Vc", function()
    vim.api.nvim_set_current_dir(vim.fn.stdpath("config"))
    vim.cmd("e $MYVIMRC")
end, { desc = "Edit [C]onfig" })

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
