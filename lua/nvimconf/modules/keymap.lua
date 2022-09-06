local M = {}

local reload = function()
  local re = require("plenary.reload").reload_module
  vim.ui.input({ prompt = "Module to reload: " }, function(input)
    if input ~= nil then
      re(input)
    end
  end)
end

local key = require("nvimconf.core.keys")
local nmap = key.nmap
local cmd = key.cmd
local opts = key.opts({ silent = true })

nmap({
    {"<S-h>", cmd("BufferLineCyclePrev"), opts},
    {"<S-l>", cmd("BufferLineCycleNext"), opts},
})

M.keys = {
  n = {
    opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    },
    mappings = {
      w = { "<cmd>w!<cr>", "Save" },
      q = { "<cmd>Bdelete!<cr>", "Close Buffer" },
      Q = { "<cmd>q!<cr>", "Quit" },
      h = { "<cmd>nohl<cr>", "Highlighted Search" },
      c = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Toggle Comment" },
      -- e = { "<cmd>NeoTreeShowToggle<CR>", "Toggle NeoTree" },
      e = { "<cmd>RnvimrToggle<CR>", "Toggle Ranger" },
      m = { "<cmd>lua require('keystack').push('page_moving')<CR>", "Movement" },
      v = {
        name = "Vim Stuff",
        c = { "<cmd>e $CFGS/nvim/<CR>", "Edit Inits" },
        l = { "<cmd>e $CFGS/nvim/lua/<CR>", "Edit Lua" },
        s = { "<cmd>source %<CR>", "Source Current" },
      },
      l = {
        name = "Lsp Stuff",
        f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename" },
        h = { "<cmd>Lspsaga hover_doc<CR>", "Documentation" },
        a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
        s = { "<cmd>Lspsaga signature_help<CR>", "Signature" },
        p = { "<cmd>Lspsaga preview_definition<CR>", "Prev. Definition" },
        d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Diagnostics" },
        m = { "<cmd>lua require('keystack').push('diagnostic_moving')<CR>", "Diagnostics Movement" },
        o = { "<cmd>LSoutlineToggle<CR>", "Outline" },
        l = { "<cmd>lua require('lsp_lines').toggle()<CR>", "Lines" },
      },
      g = {
        name = "Git Stuff",
        l = { "<cmd>LazyGit<CR>", "Lazygit" },
        m = { "<cmd>lua require('keystack').push('hunk_moving')<CR>", "Movement" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
        d = { "<cmd>Gitsigns diff_hunk<CR>", "Diff Hunk" },
      },
      G = {
        name = "Goto Stuff",
        f = { "gf", "Goto File" },
        d = { "<cmd>Lspsaga lsp_finder<CR>", "Definition/References" },
        -- d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        -- D = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
        -- r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
        c = { "<cmd>lua vim.lsp.buf.code_lens()<CR>", "Code Lens" },
        p = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbol" },
        -- s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
        o = { "<cmd>lua vim.lsp.buf.document_link()<CR>", "Document Link" },
        u = { "<cmd>lua vim.lsp.buf.document_color()<CR>", "Document Color" },
      },
      b = {
        name = "Buffer Stuff",
        c = { "<cmd>BufferLinePickClose<CR>", "Close Buffer" },
      },
      u = {
        name = "Usefull Stuff",
        v = { "<cmd>lua require('usefull').vip()<CR>", "Prints Inspect of Table" },
        R = { "<cmd>lua require('usefull').reloadPlug()<CR>", "Reloads a Plugin" },
        r = { reload, "Reloads the Module" },
      },
      ["<leader>"] = { "<cmd>lua require('which-key').show(' ')<CR>", "Show Whichkey" },
    },
  },
  v = {
    opts = {
      mode = "v",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    },
    mappings = {
      c = { "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
      -- a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
      a = { "<cmd><C-U>Lspsaga range_code_action<CR>", "Code Actions" },
      f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format" },
    },
  },
}

return M
