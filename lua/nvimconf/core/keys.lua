local keymap = {}

function keymap.opts(tbl)
    vim.validate({ tbl = {tbl, 'table'} })
    local opts = vim.tbl_deep_extend("keep", tbl, { silent = false, noremap = false, expr = false, remap = false, nowait = false })
    return opts
end

function keymap.cmd(str)
  return '<cmd>' .. str .. '<CR>'
end

function keymap.cu(str)
  return '<C-u><cmd>' .. str .. '<CR>'
end

--@private
local keymap_set = function(mode, tbl)
  vim.validate({
    tbl = { tbl, 'table' },
  })
  local len = #tbl
  if len < 2 then
    vim.notify('keymap must has rhs')
    return
  end

  local options = len == 3 and tbl[3] or keymap.opts({})

  vim.keymap.set(mode, tbl[1], tbl[2], options)
end

local function map(mod)
  return function(tbl)
    vim.validate({
      tbl = { tbl, 'table' },
    })

    if type(tbl[1]) == 'table' and type(tbl[2]) == 'table' then
      for _, v in pairs(tbl) do
        keymap_set(mod, v)
      end
    else
      keymap_set(mod, tbl)
    end
  end
end

keymap.nmap = map('n')
keymap.imap = map('i')
keymap.cmap = map('c')
keymap.vmap = map('v')
keymap.xmap = map('x')
keymap.tmap = map('t')

return keymap
