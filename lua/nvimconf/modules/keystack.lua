return function(keystack)
  keystack.config {
    mappings = {
      ["page_moving"] = {
        maps = {
          ["j"] = "<C-D>",
          ["k"] = "<C-U>",
        },
      },
      ["table_edit"] = {
        on_push = function ()
            vim.cmd [[set virtualedit=all]]
        end,
        on_pop = function()
            vim.cmd [[set virtualedit=none]]
        end,
        maps = {
          ["n"] = ""
        },
      },
      ["hunk_moving"] = {
        maps = {
          ["j"] = "<cmd>Gitsigns next_hunk<CR>",
          ["k"] = "<cmd>Gitsigns previous_hunk<CR>",
        },
      },
      ["diagnostic_moving"] = {
        maps = {
          ["j"] = "<cmd>Lspsaga diagnostic_jump_next<CR>",
          ["k"] = "<cmd>Lspsaga diagnostic_jump_prev<CR>",
        },
      },
    },
  }
end
