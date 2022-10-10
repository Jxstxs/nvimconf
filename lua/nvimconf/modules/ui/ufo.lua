return function(ufo)
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    ufo.setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds = { 'imports', 'comment' },
        preview = {
            win_config = {
                border = { '', '─', '', '', '', '─', '', '' },
                winhighlight = 'Normal:Folded',
                winblend = 0
            },
            mappings = {
                scrollU = '<C-u>',
                scrollD = '<C-d>'
            }
        },
        provider_selector = function(bufnr, filetype, buftype)
            -- if you prefer treesitter provider rather than lsp,
            -- return ftMap[filetype] or {'treesitter', 'indent'}
            return ftMap[filetype]

            -- refer to ./doc/example.lua for detail
        end
    })
end
