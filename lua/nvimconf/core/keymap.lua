local keys = require("nvimconf.core.keys")

local nmap, vmap, imap = keys.nmap, keys.vmap, keys.imap
local cmd = keys.cmd
local opts = keys.opts({ silent = true })

vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

nmap({
    -- Easier Window Movement
    {"<C-h>", "<C-w>h", opts},
    {"<C-j>", "<C-w>j", opts},
    {"<C-k>", "<C-w>k", opts},
    {"<C-l>", "<C-w>l", opts},

    -- Resizing Windows
    -- {"<C-H>", cmd("resize -2"), opts},
    -- {"<C-J>", cmd("resize +2"), opts},
    -- {"<C-K>", cmd("vertical resize -2"), opts},
    -- {"<C-L>", cmd("vertical resize +2"), opts},

    -- Buffer Navigation
    {"<S-h>", cmd("bnext"), opts},
    {"<S-l>", cmd("bprevious"), opts},
})

vmap({
    -- Better paste
    {"p", '"_dP', opts},

    -- Better Indentations
    {"<", "<gv", opts},
    {">", ">gv", opts},
})

imap({
    -- Quit Insert Mode
    {"jj", "<ESC>", opts},

    -- Easier Movement
    {"<C-h>", "<Left>", opts},
    {"<C-j>", "<Down>", opts},
    {"<C-k>", "<Up>", opts},
    {"<C-l>", "<Right>", opts},
})
